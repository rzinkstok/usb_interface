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
    
    input wire cmd_read_en,
    output wire cmd_ready,
    output wire [7:0] cmd_byte_debug
);
    wire [39:0] cmd;
    assign cmd_byte_debug = cmd[39:32];
    
    usb_interface usbif(
        clk,
        rst_n,
    
    clkout,
        data,
        rxf_n,
        txe_n,
        rd_n,
        wr_n,
        oe_n,
        siwu,
        cmd,
        cmd_ready,
        cmd_read_en
    );
    
endmodule

`default_nettype wire