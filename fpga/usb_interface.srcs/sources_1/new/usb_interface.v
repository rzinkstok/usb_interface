`timescale 1ns / 1ps
`default_nettype none

module usb_interface(
    input wire clk,
    input wire rst_n,
    
    // FT2232H signals
    input wire clkout,
    inout wire [7:0] data,
    input wire rxf_n,       // Signifies data is available from FTDI when low
    input wire txe_n,       // Signifies data can be written to FTDI when low
    output wire rd_n,       // Output data from FTDI when low
    output wire wr_n,       // Writes data to FTDI when low
    output wire oe_n,       // Output enable, should be low before driving rd_n low
    output wire siwu,       // Not used
    
    // Incoming command outputs
    output wire [39:0] cmd,
    output wire cmd_ready,
    input wire cmd_read_en,
    
    // Outgoing message inputs
    input wire [39:0] read_msg,
    input wire read_msg_ready
    
    // Output
    //output wire dbg_clkout
);
    //assign dbg_clkout = clkout;
    
    /*******************************************************************************.
    * FSM States                                                                    *
    '*******************************************************************************/
    localparam IDLE  = 0,
               READ1 = 1,
               READ2 = 2,
               WRITE = 3;
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    /*******************************************************************************.
    * FT2232H Control Signals                                                       *
    '*******************************************************************************/
    // SIWU is unused, so just hold it high
    assign siwu = 1'b1;
    assign wr_n = (state != WRITE);
    assign oe_n = ~((state == READ1) | (state == READ2));
    assign rd_n = (state != READ2);
    
    
    
    /*******************************************************************************.
    * Command Receiver                                                              *
    '*******************************************************************************/
    // Prevent data from showing up after rxf_n has gone high
    wire [7:0] rx_data_in;
    assign rx_data_in = rxf_n ? 8'bZ : data;
    
    // As long as we are in READ2, new RX data is available from the chip
    // As READ2 lasts 1 cycle longer than needed, add the rxf_n dependency.
    wire rx_data_ready;
    assign rx_data_ready = (state == READ2) & (~rxf_n);
    
    wire [39:0] cmd_in;
    wire cmd_valid;
    
    // Command FIFO state flags 
    wire cmd_fifo_full;
    wire cmd_fifo_empty;
    
    // Command readiness flag for the user of this interface. This is also
    // predicated on the read message FIFO not being full, since accepting
    // a command could potentially trigger generation of a new read response
    // message before that queue can be emptied.
    //wire read_fifo_full;
    assign cmd_ready = (!cmd_fifo_empty); // && (!read_fifo_full);

    // Command receiver
    cmd_receiver cmd_rx(
        .clk(clkout),
        .rst_n(rst_n),
        .data(rx_data_in),
        .data_ready(rx_data_ready),
        .cmd_valid(cmd_valid),
        .cmd_msg(cmd_in)
    );
    
    // Queue of completed incoming commands
    cmd_fifo cmd_queue(
        .rst(!rst_n),
        .wr_clk(clkout),
        .rd_clk(clk),
        .din(cmd_in),
        .wr_en(cmd_valid),
        .rd_en(cmd_read_en),
        .dout(cmd),
        .full(cmd_fifo_full), 
        .empty(cmd_fifo_empty)
    );

    /*******************************************************************************.
    * USB Interface State Machine                                                   *
    '*******************************************************************************/
    always @(posedge clkout or negedge rst_n) begin
        if (~rst_n) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = state;
    
        case (state)
            IDLE: begin
                if (~rxf_n) begin
                    // If we have room for command bytes and there is some available,
                    // kick off a read. READ1 will assert OE#, and READ2 will assert
                    // RD# and actually clock out the data.
                    next_state = READ1;
                end else if (~txe_n) begin
                    // If we have data to send and the chip has room to accept it,
                    // kick off a write
                    next_state = WRITE;
                end
            end
        
            READ1: begin
                if (rxf_n) begin
                    // Somehow the data was lost before we had a chance to read it. Go
                    // back to IDLE.
                    next_state = IDLE;
                end else begin
                    next_state = READ2;
                end
            end
        
            READ2: begin
                if (rxf_n) begin
                    // Continue reading bytes until we've either got it all, or our
                    // command FIFO is full
                    next_state = IDLE;
                end
            end
        
            WRITE: begin
                if (txe_n | (~rxf_n)) begin
                    // Continue writing until 
                    next_state = IDLE;
                end
            end
        endcase
    end    
endmodule

`default_nettype wire