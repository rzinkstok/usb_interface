`timescale 1ns / 1ps


module usb_interface(
    input wire clk,
    input wire rst_n,
    
    // FT2232H FIFO interface
    input wire clkout,
    inout wire [7:0] data,
    input wire rxf_n,
    input wire txe_n,
    output wire rd_n,
    output wire wr_n,
    output wire oe_n,
    output wire siwu,
    
    // Incoming command data
    output wire [39:0] cmd,
    output wire cmd_ready,
    input wire cmd_read_en,
    
    // Outgoing reply message
    input wire [39:0] read_msg,
    input wire read_msg_ready
    );
    
    
    
endmodule
