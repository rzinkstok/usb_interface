// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Sun Feb  2 14:50:21 2020
// Host        : fpgadev running 64-bit Ubuntu 18.04.3 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/rzinkstok/usb_interface/fpga/usb_interface.sim/sim_1/impl/func/xsim/usb_interface_tb_func_impl.v
// Design      : usb_interface
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module cmd_receiver
   (rx_state_OBUF,
    rst_n,
    Q,
    data_IBUF,
    state,
    rst_n_IBUF,
    dbg_clkout_OBUF_BUFG);
  output [1:0]rx_state_OBUF;
  output rst_n;
  output [7:0]Q;
  input [7:0]data_IBUF;
  input [1:0]state;
  input rst_n_IBUF;
  input dbg_clkout_OBUF_BUFG;

  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[0]_i_2_n_0 ;
  wire \FSM_sequential_state[0]_i_3_n_0 ;
  wire \FSM_sequential_state[0]_i_4_n_0 ;
  wire \FSM_sequential_state[0]_i_5_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_3_n_0 ;
  wire \FSM_sequential_state[1]_i_4_n_0 ;
  wire \FSM_sequential_state[1]_i_5_n_0 ;
  wire \FSM_sequential_state[1]_i_6_n_0 ;
  wire \FSM_sequential_state[1]_i_7_n_0 ;
  wire \FSM_sequential_state[1]_i_8_n_0 ;
  wire [7:0]Q;
  wire \cmd_msg[0]_i_1_n_0 ;
  wire \cmd_msg[1]_i_1_n_0 ;
  wire \cmd_msg[2]_i_1_n_0 ;
  wire \cmd_msg[3]_i_1_n_0 ;
  wire \cmd_msg[4]_i_1_n_0 ;
  wire \cmd_msg[5]_i_1_n_0 ;
  wire \cmd_msg[6]_i_1_n_0 ;
  wire \cmd_msg[7]_i_1_n_0 ;
  wire \cmd_msg[7]_i_2_n_0 ;
  wire \cmd_msg[7]_i_3_n_0 ;
  wire \cmd_msg[7]_i_4_n_0 ;
  wire [7:0]data_IBUF;
  wire dbg_clkout_OBUF_BUFG;
  wire [1:1]next_state__0;
  wire rst_n;
  wire rst_n_IBUF;
  wire [1:0]rx_state_OBUF;
  wire [1:0]state;
  wire [1:0]state__0;
  wire [2:0]write_index;
  wire \write_index[0]_i_1_n_0 ;
  wire \write_index[0]_i_2_n_0 ;
  wire \write_index[1]_i_1_n_0 ;
  wire \write_index[1]_i_2_n_0 ;
  wire \write_index[2]_i_1_n_0 ;
  wire \write_index[2]_i_2_n_0 ;
  wire \write_index[2]_i_3_n_0 ;
  wire \write_index[2]_i_4_n_0 ;
  wire \write_index[2]_i_6_n_0 ;
  wire \write_index[2]_i_7_n_0 ;

  LUT6 #(
    .INIT(64'hFF08FF08FF0CBB0C)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(\FSM_sequential_state[0]_i_2_n_0 ),
        .I1(\FSM_sequential_state[1]_i_3_n_0 ),
        .I2(\FSM_sequential_state[0]_i_3_n_0 ),
        .I3(state__0[0]),
        .I4(\FSM_sequential_state[0]_i_4_n_0 ),
        .I5(state__0[1]),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00000040)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(data_IBUF[1]),
        .I1(data_IBUF[2]),
        .I2(data_IBUF[4]),
        .I3(state__0[0]),
        .I4(\FSM_sequential_state[1]_i_8_n_0 ),
        .O(\FSM_sequential_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555554)) 
    \FSM_sequential_state[0]_i_3 
       (.I0(state__0[1]),
        .I1(\FSM_sequential_state[1]_i_7_n_0 ),
        .I2(data_IBUF[3]),
        .I3(data_IBUF[2]),
        .I4(data_IBUF[0]),
        .I5(data_IBUF[5]),
        .O(\FSM_sequential_state[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0101010101000101)) 
    \FSM_sequential_state[0]_i_4 
       (.I0(write_index[1]),
        .I1(write_index[0]),
        .I2(write_index[2]),
        .I3(\FSM_sequential_state[1]_i_8_n_0 ),
        .I4(data_IBUF[0]),
        .I5(\FSM_sequential_state[0]_i_5_n_0 ),
        .O(\FSM_sequential_state[0]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \FSM_sequential_state[0]_i_5 
       (.I0(data_IBUF[1]),
        .I1(data_IBUF[2]),
        .I2(data_IBUF[4]),
        .O(\FSM_sequential_state[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hF250F050F050F050)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(\FSM_sequential_state[1]_i_3_n_0 ),
        .I1(\FSM_sequential_state[1]_i_4_n_0 ),
        .I2(state__0[1]),
        .I3(state__0[0]),
        .I4(\FSM_sequential_state[1]_i_5_n_0 ),
        .I5(\FSM_sequential_state[1]_i_6_n_0 ),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(rst_n_IBUF),
        .O(rst_n));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[1]_i_3 
       (.I0(state[1]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \FSM_sequential_state[1]_i_4 
       (.I0(data_IBUF[5]),
        .I1(data_IBUF[0]),
        .I2(data_IBUF[2]),
        .I3(data_IBUF[3]),
        .I4(\FSM_sequential_state[1]_i_7_n_0 ),
        .O(\FSM_sequential_state[1]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \FSM_sequential_state[1]_i_5 
       (.I0(write_index[2]),
        .I1(write_index[0]),
        .I2(write_index[1]),
        .O(\FSM_sequential_state[1]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00002000)) 
    \FSM_sequential_state[1]_i_6 
       (.I0(data_IBUF[1]),
        .I1(data_IBUF[2]),
        .I2(data_IBUF[4]),
        .I3(data_IBUF[0]),
        .I4(\FSM_sequential_state[1]_i_8_n_0 ),
        .O(\FSM_sequential_state[1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hFFF7)) 
    \FSM_sequential_state[1]_i_7 
       (.I0(data_IBUF[7]),
        .I1(data_IBUF[6]),
        .I2(data_IBUF[4]),
        .I3(data_IBUF[1]),
        .O(\FSM_sequential_state[1]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hFF7F)) 
    \FSM_sequential_state[1]_i_8 
       (.I0(data_IBUF[7]),
        .I1(data_IBUF[6]),
        .I2(data_IBUF[3]),
        .I3(data_IBUF[5]),
        .O(\FSM_sequential_state[1]_i_8_n_0 ));
  (* FSM_ENCODED_STATES = "ESCAPED:10,IDLE:00,ACTIVE:01" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(1'b1),
        .CLR(rst_n),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state__0[0]));
  (* FSM_ENCODED_STATES = "ESCAPED:10,IDLE:00,ACTIVE:01" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(1'b1),
        .CLR(rst_n),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hF800)) 
    \cmd_msg[0]_i_1 
       (.I0(\cmd_msg[7]_i_4_n_0 ),
        .I1(next_state__0),
        .I2(\cmd_msg[7]_i_3_n_0 ),
        .I3(data_IBUF[0]),
        .O(\cmd_msg[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA808080008080)) 
    \cmd_msg[1]_i_1 
       (.I0(\FSM_sequential_state[1]_i_3_n_0 ),
        .I1(data_IBUF[1]),
        .I2(next_state__0),
        .I3(\cmd_msg[7]_i_4_n_0 ),
        .I4(data_IBUF[0]),
        .I5(\cmd_msg[7]_i_3_n_0 ),
        .O(\cmd_msg[1]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \cmd_msg[2]_i_1 
       (.I0(next_state__0),
        .I1(data_IBUF[2]),
        .O(\cmd_msg[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA808080008080)) 
    \cmd_msg[3]_i_1 
       (.I0(\FSM_sequential_state[1]_i_3_n_0 ),
        .I1(data_IBUF[3]),
        .I2(next_state__0),
        .I3(\cmd_msg[7]_i_4_n_0 ),
        .I4(data_IBUF[0]),
        .I5(\cmd_msg[7]_i_3_n_0 ),
        .O(\cmd_msg[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA808080008080)) 
    \cmd_msg[4]_i_1 
       (.I0(\FSM_sequential_state[1]_i_3_n_0 ),
        .I1(data_IBUF[4]),
        .I2(next_state__0),
        .I3(\cmd_msg[7]_i_4_n_0 ),
        .I4(data_IBUF[0]),
        .I5(\cmd_msg[7]_i_3_n_0 ),
        .O(\cmd_msg[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \cmd_msg[5]_i_1 
       (.I0(next_state__0),
        .I1(data_IBUF[5]),
        .O(\cmd_msg[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888808880808080)) 
    \cmd_msg[6]_i_1 
       (.I0(data_IBUF[6]),
        .I1(\FSM_sequential_state[1]_i_3_n_0 ),
        .I2(\cmd_msg[7]_i_3_n_0 ),
        .I3(data_IBUF[0]),
        .I4(\cmd_msg[7]_i_4_n_0 ),
        .I5(next_state__0),
        .O(\cmd_msg[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4444404440404040)) 
    \cmd_msg[7]_i_1 
       (.I0(state[0]),
        .I1(state[1]),
        .I2(\cmd_msg[7]_i_3_n_0 ),
        .I3(data_IBUF[0]),
        .I4(\cmd_msg[7]_i_4_n_0 ),
        .I5(next_state__0),
        .O(\cmd_msg[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888808880808080)) 
    \cmd_msg[7]_i_2 
       (.I0(data_IBUF[7]),
        .I1(\FSM_sequential_state[1]_i_3_n_0 ),
        .I2(\cmd_msg[7]_i_3_n_0 ),
        .I3(data_IBUF[0]),
        .I4(\cmd_msg[7]_i_4_n_0 ),
        .I5(next_state__0),
        .O(\cmd_msg[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000100000000000)) 
    \cmd_msg[7]_i_3 
       (.I0(\FSM_sequential_state[1]_i_8_n_0 ),
        .I1(state__0[0]),
        .I2(data_IBUF[4]),
        .I3(data_IBUF[2]),
        .I4(data_IBUF[1]),
        .I5(state__0[1]),
        .O(\cmd_msg[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hFBFF)) 
    \cmd_msg[7]_i_4 
       (.I0(\FSM_sequential_state[1]_i_8_n_0 ),
        .I1(data_IBUF[4]),
        .I2(data_IBUF[2]),
        .I3(data_IBUF[1]),
        .O(\cmd_msg[7]_i_4_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \cmd_msg_reg[0] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(\cmd_msg[7]_i_1_n_0 ),
        .CLR(rst_n),
        .D(\cmd_msg[0]_i_1_n_0 ),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \cmd_msg_reg[1] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(\cmd_msg[7]_i_1_n_0 ),
        .CLR(rst_n),
        .D(\cmd_msg[1]_i_1_n_0 ),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \cmd_msg_reg[2] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(\cmd_msg[7]_i_1_n_0 ),
        .CLR(rst_n),
        .D(\cmd_msg[2]_i_1_n_0 ),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \cmd_msg_reg[3] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(\cmd_msg[7]_i_1_n_0 ),
        .CLR(rst_n),
        .D(\cmd_msg[3]_i_1_n_0 ),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \cmd_msg_reg[4] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(\cmd_msg[7]_i_1_n_0 ),
        .CLR(rst_n),
        .D(\cmd_msg[4]_i_1_n_0 ),
        .Q(Q[4]));
  FDCE #(
    .INIT(1'b0)) 
    \cmd_msg_reg[5] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(\cmd_msg[7]_i_1_n_0 ),
        .CLR(rst_n),
        .D(\cmd_msg[5]_i_1_n_0 ),
        .Q(Q[5]));
  FDCE #(
    .INIT(1'b0)) 
    \cmd_msg_reg[6] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(\cmd_msg[7]_i_1_n_0 ),
        .CLR(rst_n),
        .D(\cmd_msg[6]_i_1_n_0 ),
        .Q(Q[6]));
  FDCE #(
    .INIT(1'b0)) 
    \cmd_msg_reg[7] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(\cmd_msg[7]_i_1_n_0 ),
        .CLR(rst_n),
        .D(\cmd_msg[7]_i_2_n_0 ),
        .Q(Q[7]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \rx_state_OBUF[0]_inst_i_1 
       (.I0(state__0[0]),
        .I1(state__0[1]),
        .O(rx_state_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \rx_state_OBUF[1]_inst_i_1 
       (.I0(state__0[1]),
        .I1(state__0[0]),
        .O(rx_state_OBUF[1]));
  LUT6 #(
    .INIT(64'h333F3F3F88808080)) 
    \write_index[0]_i_1 
       (.I0(\write_index[0]_i_2_n_0 ),
        .I1(\FSM_sequential_state[1]_i_3_n_0 ),
        .I2(\write_index[2]_i_3_n_0 ),
        .I3(\write_index[2]_i_4_n_0 ),
        .I4(next_state__0),
        .I5(write_index[0]),
        .O(\write_index[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \write_index[0]_i_2 
       (.I0(state__0[1]),
        .I1(state__0[0]),
        .O(\write_index[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hBBBFBFBF88808080)) 
    \write_index[1]_i_1 
       (.I0(\write_index[1]_i_2_n_0 ),
        .I1(\FSM_sequential_state[1]_i_3_n_0 ),
        .I2(\write_index[2]_i_3_n_0 ),
        .I3(\write_index[2]_i_4_n_0 ),
        .I4(next_state__0),
        .I5(write_index[1]),
        .O(\write_index[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0660)) 
    \write_index[1]_i_2 
       (.I0(state__0[0]),
        .I1(state__0[1]),
        .I2(write_index[0]),
        .I3(write_index[1]),
        .O(\write_index[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hBBBFBFBF88808080)) 
    \write_index[2]_i_1 
       (.I0(\write_index[2]_i_2_n_0 ),
        .I1(\FSM_sequential_state[1]_i_3_n_0 ),
        .I2(\write_index[2]_i_3_n_0 ),
        .I3(\write_index[2]_i_4_n_0 ),
        .I4(next_state__0),
        .I5(write_index[2]),
        .O(\write_index[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h06666000)) 
    \write_index[2]_i_2 
       (.I0(state__0[0]),
        .I1(state__0[1]),
        .I2(write_index[1]),
        .I3(write_index[0]),
        .I4(write_index[2]),
        .O(\write_index[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h5555555500000004)) 
    \write_index[2]_i_3 
       (.I0(state__0[0]),
        .I1(\write_index[2]_i_6_n_0 ),
        .I2(data_IBUF[1]),
        .I3(data_IBUF[4]),
        .I4(\write_index[2]_i_7_n_0 ),
        .I5(state__0[1]),
        .O(\write_index[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFFDFFFFF)) 
    \write_index[2]_i_4 
       (.I0(data_IBUF[1]),
        .I1(data_IBUF[2]),
        .I2(data_IBUF[4]),
        .I3(\FSM_sequential_state[1]_i_8_n_0 ),
        .I4(data_IBUF[0]),
        .O(\write_index[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h20200020)) 
    \write_index[2]_i_5 
       (.I0(\FSM_sequential_state[1]_i_5_n_0 ),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(\write_index[2]_i_6_n_0 ),
        .I4(\FSM_sequential_state[1]_i_7_n_0 ),
        .O(next_state__0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \write_index[2]_i_6 
       (.I0(data_IBUF[3]),
        .I1(data_IBUF[2]),
        .I2(data_IBUF[0]),
        .I3(data_IBUF[5]),
        .O(\write_index[2]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \write_index[2]_i_7 
       (.I0(data_IBUF[6]),
        .I1(data_IBUF[7]),
        .O(\write_index[2]_i_7_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \write_index_reg[0] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(1'b1),
        .CLR(rst_n),
        .D(\write_index[0]_i_1_n_0 ),
        .Q(write_index[0]));
  FDCE #(
    .INIT(1'b0)) 
    \write_index_reg[1] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(1'b1),
        .CLR(rst_n),
        .D(\write_index[1]_i_1_n_0 ),
        .Q(write_index[1]));
  FDCE #(
    .INIT(1'b0)) 
    \write_index_reg[2] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(1'b1),
        .CLR(rst_n),
        .D(\write_index[2]_i_1_n_0 ),
        .Q(write_index[2]));
endmodule

(* ECO_CHECKSUM = "f4fd3508" *) (* IDLE = "0" *) (* READ1 = "1" *) 
(* READ2 = "2" *) (* WRITE = "3" *) 
(* NotValidForBitStream *)
module usb_interface
   (rst_n,
    clkout,
    data,
    rxf_n,
    txe_n,
    rd_n,
    wr_n,
    oe_n,
    siwu,
    dbg_clkout,
    rxf,
    txe,
    cmd_in,
    rx_state);
  input rst_n;
  input clkout;
  inout [7:0]data;
  input rxf_n;
  input txe_n;
  output rd_n;
  output wr_n;
  output oe_n;
  output siwu;
  output dbg_clkout;
  output rxf;
  output txe;
  output [7:0]cmd_in;
  output [1:0]rx_state;

  wire \FSM_sequential_state[0]_i_1__0_n_0 ;
  wire \FSM_sequential_state[1]_i_1__0_n_0 ;
  wire clkout;
  wire [7:0]cmd_in;
  wire [7:0]cmd_in_OBUF;
  wire cmd_rx_n_2;
  wire [7:0]data;
  wire [7:0]data_IBUF;
  wire dbg_clkout;
  wire dbg_clkout_OBUF;
  wire dbg_clkout_OBUF_BUFG;
  wire oe_n;
  wire oe_n_OBUF;
  wire rd_n;
  wire rd_n_OBUF;
  wire rst_n;
  wire rst_n_IBUF;
  wire [1:0]rx_state;
  wire [1:0]rx_state_OBUF;
  wire rxf;
  wire rxf_OBUF;
  wire rxf_n;
  wire rxf_n_IBUF;
  wire siwu;
  wire [1:0]state;
  wire txe;
  wire txe_OBUF;
  wire txe_n;
  wire txe_n_IBUF;
  wire wr_n;
  wire wr_n_OBUF;
PULLUP pullup_rst_n
       (.O(rst_n));

  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h0911)) 
    \FSM_sequential_state[0]_i_1__0 
       (.I0(state[1]),
        .I1(state[0]),
        .I2(txe_n_IBUF),
        .I3(rxf_n_IBUF),
        .O(\FSM_sequential_state[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h0966)) 
    \FSM_sequential_state[1]_i_1__0 
       (.I0(state[1]),
        .I1(state[0]),
        .I2(txe_n_IBUF),
        .I3(rxf_n_IBUF),
        .O(\FSM_sequential_state[1]_i_1__0_n_0 ));
  (* FSM_ENCODED_STATES = "WRITE:11,READ1:01,READ2:10,IDLE:00" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(1'b1),
        .CLR(cmd_rx_n_2),
        .D(\FSM_sequential_state[0]_i_1__0_n_0 ),
        .Q(state[0]));
  (* FSM_ENCODED_STATES = "WRITE:11,READ1:01,READ2:10,IDLE:00" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(dbg_clkout_OBUF_BUFG),
        .CE(1'b1),
        .CLR(cmd_rx_n_2),
        .D(\FSM_sequential_state[1]_i_1__0_n_0 ),
        .Q(state[1]));
  IBUF clkout_IBUF_inst
       (.I(clkout),
        .O(dbg_clkout_OBUF));
  OBUF \cmd_in_OBUF[0]_inst 
       (.I(cmd_in_OBUF[0]),
        .O(cmd_in[0]));
  OBUF \cmd_in_OBUF[1]_inst 
       (.I(cmd_in_OBUF[1]),
        .O(cmd_in[1]));
  OBUF \cmd_in_OBUF[2]_inst 
       (.I(cmd_in_OBUF[2]),
        .O(cmd_in[2]));
  OBUF \cmd_in_OBUF[3]_inst 
       (.I(cmd_in_OBUF[3]),
        .O(cmd_in[3]));
  OBUF \cmd_in_OBUF[4]_inst 
       (.I(cmd_in_OBUF[4]),
        .O(cmd_in[4]));
  OBUF \cmd_in_OBUF[5]_inst 
       (.I(cmd_in_OBUF[5]),
        .O(cmd_in[5]));
  OBUF \cmd_in_OBUF[6]_inst 
       (.I(cmd_in_OBUF[6]),
        .O(cmd_in[6]));
  OBUF \cmd_in_OBUF[7]_inst 
       (.I(cmd_in_OBUF[7]),
        .O(cmd_in[7]));
  cmd_receiver cmd_rx
       (.Q(cmd_in_OBUF),
        .data_IBUF(data_IBUF),
        .dbg_clkout_OBUF_BUFG(dbg_clkout_OBUF_BUFG),
        .rst_n(cmd_rx_n_2),
        .rst_n_IBUF(rst_n_IBUF),
        .rx_state_OBUF(rx_state_OBUF),
        .state(state));
  IBUF \data_IBUF[0]_inst 
       (.I(data[0]),
        .O(data_IBUF[0]));
  IBUF \data_IBUF[1]_inst 
       (.I(data[1]),
        .O(data_IBUF[1]));
  IBUF \data_IBUF[2]_inst 
       (.I(data[2]),
        .O(data_IBUF[2]));
  IBUF \data_IBUF[3]_inst 
       (.I(data[3]),
        .O(data_IBUF[3]));
  IBUF \data_IBUF[4]_inst 
       (.I(data[4]),
        .O(data_IBUF[4]));
  IBUF \data_IBUF[5]_inst 
       (.I(data[5]),
        .O(data_IBUF[5]));
  IBUF \data_IBUF[6]_inst 
       (.I(data[6]),
        .O(data_IBUF[6]));
  IBUF \data_IBUF[7]_inst 
       (.I(data[7]),
        .O(data_IBUF[7]));
  BUFG dbg_clkout_OBUF_BUFG_inst
       (.I(dbg_clkout_OBUF),
        .O(dbg_clkout_OBUF_BUFG));
  OBUF dbg_clkout_OBUF_inst
       (.I(dbg_clkout_OBUF_BUFG),
        .O(dbg_clkout));
  OBUF oe_n_OBUF_inst
       (.I(oe_n_OBUF),
        .O(oe_n));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h9)) 
    oe_n_OBUF_inst_i_1
       (.I0(state[0]),
        .I1(state[1]),
        .O(oe_n_OBUF));
  OBUF rd_n_OBUF_inst
       (.I(rd_n_OBUF),
        .O(rd_n));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'hB)) 
    rd_n_OBUF_inst_i_1
       (.I0(state[0]),
        .I1(state[1]),
        .O(rd_n_OBUF));
  IBUF rst_n_IBUF_inst
       (.I(rst_n),
        .O(rst_n_IBUF));
  OBUF \rx_state_OBUF[0]_inst 
       (.I(rx_state_OBUF[0]),
        .O(rx_state[0]));
  OBUF \rx_state_OBUF[1]_inst 
       (.I(rx_state_OBUF[1]),
        .O(rx_state[1]));
  OBUF rxf_OBUF_inst
       (.I(rxf_OBUF),
        .O(rxf));
  LUT1 #(
    .INIT(2'h1)) 
    rxf_OBUF_inst_i_1
       (.I0(rxf_n_IBUF),
        .O(rxf_OBUF));
  IBUF rxf_n_IBUF_inst
       (.I(rxf_n),
        .O(rxf_n_IBUF));
  OBUF siwu_OBUF_inst
       (.I(1'b1),
        .O(siwu));
  OBUF txe_OBUF_inst
       (.I(txe_OBUF),
        .O(txe));
  LUT1 #(
    .INIT(2'h1)) 
    txe_OBUF_inst_i_1
       (.I0(txe_n_IBUF),
        .O(txe_OBUF));
  IBUF txe_n_IBUF_inst
       (.I(txe_n),
        .O(txe_n_IBUF));
  OBUF wr_n_OBUF_inst
       (.I(wr_n_OBUF),
        .O(wr_n));
  LUT2 #(
    .INIT(4'h7)) 
    wr_n_OBUF_inst_i_1
       (.I0(state[1]),
        .I1(state[0]),
        .O(wr_n_OBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
