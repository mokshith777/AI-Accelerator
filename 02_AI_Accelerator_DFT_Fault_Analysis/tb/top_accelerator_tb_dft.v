`timescale 1ns / 1ps

module top_accelerator_tb_dft;

    parameter DATA_WIDTH = 8;
    parameter ACC_WIDTH = 20;

    reg clk;
    reg rst_n;
    reg en;
    reg load_w;
    reg scan_en;
    reg scan_in;
    reg [DATA_WIDTH-1:0] a0, a1, a2, a3;
    reg [DATA_WIDTH-1:0] b0, b1, b2, b3;

    wire scan_out;
    wire [ACC_WIDTH-1:0] acc00, acc01, acc02, acc03;
    wire [ACC_WIDTH-1:0] acc10, acc11, acc12, acc13;
    wire [ACC_WIDTH-1:0] acc20, acc21, acc22, acc23;
    wire [ACC_WIDTH-1:0] acc30, acc31, acc32, acc33;

    initial begin
       $dumpfile("dft_faulty_waves.vcd");
       $dumpvars(0, top_accelerator_tb_dft);
    end
       
    top_accelerator #(DATA_WIDTH, ACC_WIDTH) dut (
        .clk(clk), .rst_n(rst_n), .en(en), .load_w(load_w), .scan_en(scan_en), .scan_in(scan_in), .scan_out(scan_out),
        .a0(a0), .a1(a1), .a2(a2), .a3(a3),
        .b0(b0), .b1(b1), .b2(b2), .b3(b3),
        .acc00(acc00), .acc01(acc01), .acc02(acc02), .acc03(acc03),
        .acc10(acc10), .acc11(acc11), .acc12(acc12), .acc13(acc13),
        .acc20(acc20), .acc21(acc21), .acc22(acc22), .acc23(acc23),         .acc30(acc30), .acc31(acc31), .acc32(acc32), .acc33(acc33)
    );

    always #5 clk = ~clk;

    initial begin
        
        clk = 0; rst_n = 0; en = 0; load_w = 0;
        scan_en = 0; scan_in = 0;
        a0 = 0; a1 = 0; a2 = 0; a3 = 0;
        b0 = 0; b1 = 0; b2 = 0; b3 = 0;

        #20 rst_n = 1;
        #10;

        load_w = 1; en = 1;
        b0 = 8'd1; b1 = 8'd1; b2 = 8'd1; b3 = 8'd1; #10;
        b0 = 8'd1; b1 = 8'd1; b2 = 8'd1; b3 = 8'd1; #10;
        b0 = 8'd1; b1 = 8'd1; b2 = 8'd1; b3 = 8'd1; #10;
        b0 = 8'd1; b1 = 8'd1; b2 = 8'd1; b3 = 8'd1; #10;
        load_w = 0;
        
        a0 = 8'd1; a1 = 8'd1; a2 = 8'd1; a3 = 8'd1; #10;
        a0 = 8'd2; a1 = 8'd2; a2 = 8'd2; a3 = 8'd2; #10;
        a0 = 8'd3; a1 = 8'd3; a2 = 8'd3; a3 = 8'd3; #10;
        a0 = 8'd4; a1 = 8'd4; a2 = 8'd4; a3 = 8'd4; #10;
        
        a0 = 0; a1 = 0; a2 = 0; a3 = 0;

        #100;
        
        $display("Simulation complete. Open waves.vcd to see the result!");
        $finish;
    end

endmodule
