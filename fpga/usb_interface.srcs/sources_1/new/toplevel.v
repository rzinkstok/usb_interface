`timescale 1ns / 1ps
`default_nettype none

module toplevel(
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
    
    output wire mnhrpt,
    output wire nhalga
);

    /*******************************************************************************.
    * USB Interface                                                                 *
    '*******************************************************************************/
    
    // Incoming command from USB, associated validity flag, and read signal
    wire [39:0] cmd;
    wire cmd_ready;
    wire cmd_read_en;
    
    // Read response message for sending back over USB, and its validity flag
    wire [39:0] read_msg;
    wire read_msg_ready;

    usb_interface usbif(
        .clk(clk),
        .rst_n(rst_n),
        .clkout(clkout),
        .data(data),
        .rxf_n(rxf_n),
        .txe_n(txe_n),
        .rd_n(rd_n),
        .wr_n(wr_n),
        .oe_n(oe_n),
        .siwu(siwu),
        .cmd(cmd),
        .cmd_ready(cmd_ready),
        .cmd_read_en(cmd_read_en),
        .read_msg(read_msg),
        .read_msg_ready(read_msg_ready)
    );
    
    /*******************************************************************************.
    * Command Controller                                                            *
    '*******************************************************************************/
    // Address and (if applicable) data associated with the command currently
    // being processed
    wire [15:0] cmd_addr;
    wire [15:0] cmd_data;
    
    // Control Registers control signals
    wire ctrl_read_en;
    wire ctrl_write_en;
    wire ctrl_write_done;
    wire [15:0] ctrl_data;

    // Resulting data from the active read command
    wire [15:0] read_data;
    assign read_data = ctrl_data;
    
    // Command controller 
    cmd_controller cmd_ctrl(
        .clk(clk),
        .rst_n(rst_n),
        .cmd(cmd),
        .cmd_ready(cmd_ready),
        .cmd_read_en(cmd_read_en),
        .cmd_addr(cmd_addr),
        .cmd_data(cmd_data),
        .read_data(read_data),
        .read_msg(read_msg),
        .read_msg_ready(read_msg_ready),
        .ctrl_read_en(ctrl_read_en),
        .ctrl_write_en(ctrl_write_en),
        .ctrl_write_done(ctrl_write_done)
    );
    
    /*******************************************************************************.
    * Control Registers                                                             *
    '*******************************************************************************/

    control_regs ctrl_regs(
        .clk(clk),
        .rst_n(rst_n),
    
        .addr(cmd_addr),
        .data_in(cmd_data),
        .read_en(ctrl_read_en),
        .write_en(ctrl_write_en),
        .write_done(ctrl_write_done),
        .data_out(ctrl_data),
        .mnhrpt(mnhrpt),
        .nhalga(nhalga)
    );
endmodule

`default_nettype wire