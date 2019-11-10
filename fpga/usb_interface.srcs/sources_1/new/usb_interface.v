`timescale 1ns / 1ps


module usb_interface(
    input wire clk,
    input wire rst_n,
    
    // FT2232H FIFO interface
    input wire clkout,      // interface clock
    inout wire [7:0] data,  // data bus
    input wire rxf_n,       // when high, do not read (incoming fifo empty)
    input wire txe_n,       // when high, do not write (outgoing fifo full)
    output wire rd_n,       // when low, grab a byte from the incoming fifo and put it on the data bus at next clock rising edge
    output wire wr_n,       // when low, grab a byte from the data bus and put in on the outgoing fifo at next clock rising edge
    output wire oe_n,       // when low, enable data to be output on the bus for reading
    output wire siwu,       // not used
    
    // Incoming command data
    output wire [39:0] cmd,
    output wire cmd_available,
    input wire cmd_read_en,
    
    // Outgoing reply message
    input wire [39:0] msg,
    input wire msg_available
    );

    // FT2232H control signals
    assign siwu = 1'b1; // not used
    assign wr_n = ~(state == WRITE);
    assign oe_n = ~((state == READ1) | (state == READ2));
    assign rd_n = ~(state == READ2);

    /***************************************
    * Command receiver                     *
    ***************************************/
    // Grabs bytes from the FT2232H and collects them into completed command messages that are placed on the command FIFO

    // While we're in the READ2 state, there is data available from the FT2232H.
    wire rx_data_available;
    assign rx_data_available = (state == READ2);

    // When a complete command was received, cmd_valid is asserted, and the command is available on cmd_in.
    wire cmd_valid;
    wire [39:0] cmd_in;

    // Command receiver
    cmd_recever cmd_rcvr(
        .clk(clkout),
        .rst_n(rst_n),
        .data(data),
        .data_available(rx_data_available),
        .cmd_valid(cmd_valid),
        .cmd_msg(cmd_in)
    );

    // Command FIFO state flags
    wire cmd_fifo_empty;
    wire cmd_fifo_full;
    wire cmd_available;


    // Command FIFO: queue of incoming commands
    cmd_fifo cmd_queue(
        .rst(~rst_n),
        .wr_clk(clkout),
        .rd_clk(clk),
        .din(cmd_in),
        .wr_en(cmd_valid),
        .rd_en(cmd_read_en),
        .dout(cmd),
        .full(cmd_fifo_full),
        .empty(cmd_fifo_empty)
    );


    /***************************************
    * Message sender                       *
    ***************************************/
    // Any message placed on the message queue is processed by the message sender into slipped bytes that are placed on the
    // outgoing byte queue

    // Message data from message FIFO to sender
    wire [39:0] msg_out;

    // Message FIFO status flags
    wire msg_fifo_full;
    wire msg_fifo_empty;
    wire msg_out_available;
    assign msg_out_available = ~msg_fifo_empty;

    // Sender status flags
    wire sender_ready;

    // Byte data from sender to byte FIFO
    wire out_byte_available;
    wire [7:0] out_byte;

    // Byte output from byte FIFO to FT2232H
    wire [7:0] tx_byte;
    wire tx_byte_read_en;
    assign tx_byte_read_en = ((~wr_n) & (~txe_n));
    assign data = (tx_byte_read_en) ? tx_byte : 8'bZ;


    // Message FIFO: queue of outgoing messages
    msg_fifo msg_queue(
        .clk(clk),
        .srst(~rst_n),
        .din(msg),
        .wr_en(msg_available),
        .rd_en(sender_ready),
        .dout(msg_out),
        .full(msg_fifo_full),
        .empty(msg_fifo_empty)
    );


    msg_sender msg_sndr(
        .clk(clk),
        .rst_n(rst_n),
        .msg(msg_out),
        .msg_available(msg_out_available),
        .sender_ready(sender_ready),
        .out_byte(out_byte),
        .out_byte_available(out_byte_available),
        .byte_fifo_full(byte_fifo_full)
    );


    byte_fifo byte_queue(
        .rst(~rst_n),
        .wr_clk(clk),
        .rd_cld(clkout),
        .din(out_byte),
        .wr_en(out_byte_available),
        .rd_en(tx_byte_read_en),
        .dout(tx_byte),
        .full(byte_fifo_full),
        .empty(byte_fifo_empty),
        .almost_empty(byte_fifo_almost_empty)
    );


    /***************************************
    * FT2232H interface state machine      *
    ***************************************/

    localparam  IDLE  = 0,
                READ1 = 1,
                READ2 = 2,
                WRITE = 3;

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clkout or negedge rst_n) begin
        if (~rst_n) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        case(state)
            IDLE: begin
                // Check whether to start a read: the command FIFO should not be full and there should be data available on the FT2232H
                // Check whether to start a write: the read byte FIFO should not be empty and the FT22332H should have room to accept it
                // Read has preference over write

                if ((~cmd_fifo_full) & (~rxf_n)) begin
                    next_state = READ1;
                end else if ((~read_byte_fifo_empty) & (~txe_n)) begin
                    next_state = WRITE;
                end
            end

            READ1: begin
                // This state asserts OE#, so the FT2232H will start outputting data to the bus
                if (rxf_n) begin
                    // Apparently the data has gone, so go back to idle
                    next_state = IDLE;
                end else begin
                    next_state = READ2;
                end
            end

            READ2: begin
                // This state asserts RD#, so data is clocked out of the FT2232H
                // Stay in this state untill there is no more data to read or the command FIFO is full
                if (rxf_n | cmd_fifo_full) begin
                    next_state = IDLE;
                end
            end

            WRITE: begin
                // This state asserts WR#, so data is clocked into the FT2232H
                // Stay in this state untill there is (almost) no more data to be sent, or the FT2232H has no more room
                // Also leave this state if there is incoming data to be read from the chip
                if (read_byte_fifo_almost_empty | txe_n | ~rxf_n) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
