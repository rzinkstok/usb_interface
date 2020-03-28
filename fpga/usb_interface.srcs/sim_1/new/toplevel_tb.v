`timescale 1ns / 1ps

module toplevel_tb();
    
    reg rst_n;
    reg clk;
    reg clkout;
    wire [7:0] data;
    reg rxf_n;
    reg txe_n;
    wire rd_n;
    wire wr_n;
    wire oe_n;
    wire siwu;
    reg [7:0] data_in;
    
    wire dbg_clkout;
    
    always #16.667 clkout = ~clkout;
    always #10 clk = ~clk;
    
    assign data = (~oe_n) ? data_in : 8'bZ; // Was dependent on rd_n
    
    toplevel tl(
        .clk(clk),
        .rst_n(rst_n),
        .clkout(clkout),
        .data(data),
        .rxf_n(rxf_n),
        .txe_n(txe_n),
        .rd_n(rd_n),
        .wr_n(wr_n),
        .oe_n(oe_n),
        .siwu(siwu)
    );
    
    initial begin
        $display($time, "<< Starting simulation >>");
        clk = 1'b0;
        rst_n = 1'b0;
        clkout = 1'b0;
        rxf_n = 1'b1;
        txe_n = 1'b1;
        data_in = 8'h00;
        
        #20 rst_n = 1'b1;
        #200 begin
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'hA0;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'h40;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'h01;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
    
        #200 begin
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'hA0;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'h04;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'h01;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
    
        #200 begin 
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'h12;
        @(posedge clkout) data_in = 8'h34;
        @(posedge clkout) data_in = 8'h56;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
    
        #200 begin
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'hA0;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'h40;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
    
        #200 begin
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'h20;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'h04;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
    
        #200 begin
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'h20;
        @(posedge clkout) data_in = 8'h00;
        @(posedge clkout) data_in = 8'h40;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
        
        #200 begin
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'h7F;
        @(posedge clkout) data_in = 8'hFF;
        @(posedge clkout) data_in = 8'hFF;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
        
        #200 begin
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'h7F;
        @(posedge clkout) data_in = 8'hDB;
        @(posedge clkout) data_in = 8'hDC;
        @(posedge clkout) data_in = 8'hFF;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
    
        #200 begin
            rxf_n = 1'b0;
            data_in = 8'hC0;
        end
        @(negedge oe_n);
        @(negedge rd_n);
        @(posedge clkout) data_in = 8'h7F;
        @(posedge clkout) data_in = 8'hFF;
        @(posedge clkout) data_in = 8'hFF;
        @(posedge clkout) data_in = 8'hC0;
        @(posedge clkout) rxf_n = 1'b1;
        
        
        #200 $finish;
    end


endmodule