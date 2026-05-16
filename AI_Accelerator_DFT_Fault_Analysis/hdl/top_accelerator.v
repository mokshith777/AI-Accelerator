module top_accelerator #(
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH = 20
)(
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   en,
    input  wire                   load_w,
    input  wire                   scan_en,
    input  wire                   scan_in,
    output wire                   scan_out,
    
    input  wire [DATA_WIDTH-1:0]  a0, a1, a2, a3,
    input  wire [DATA_WIDTH-1:0]  b0, b1, b2, b3,

    output wire [ACC_WIDTH-1:0]   acc00, acc01, acc02, acc03,
    output wire [ACC_WIDTH-1:0]   acc10, acc11, acc12, acc13,
    output wire [ACC_WIDTH-1:0]   acc20, acc21, acc22, acc23,
    output wire [ACC_WIDTH-1:0]   acc30, acc31, acc32, acc33
);

    wire [DATA_WIDTH-1:0] skewed_a0, skewed_a1, skewed_a2, skewed_a3;
    wire [DATA_WIDTH-1:0] skewed_b0, skewed_b1, skewed_b2, skewed_b3;

    data_skewer #(DATA_WIDTH) skewer_a (
        .clk(clk),
        .rst_n(rst_n), .en(en),
        .in0(a0), .in1(a1), .in2(a2), .in3(a3),
        .out0(skewed_a0), .out1(skewed_a1), .out2(skewed_a2), .out3(skewed_a3)
    );

    data_skewer #(DATA_WIDTH) skewer_b (
        .clk(clk),
        .rst_n(rst_n), .en(en),
        .in0(b0), .in1(b1), .in2(b2), .in3(b3),
        .out0(skewed_b0), .out1(skewed_b1), .out2(skewed_b2), .out3(skewed_b3)
    );

    systolic_array_4x4 #(DATA_WIDTH, ACC_WIDTH) array_inst (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .load_w(load_w),
        .scan_en(scan_en),
        .scan_in(scan_in),
        .scan_out(scan_out),
        
        
        .in_a_row0(skewed_a0), .in_a_row1(skewed_a1), .in_a_row2(skewed_a2), .in_a_row3(skewed_a3),
        .in_b_col0(skewed_b0), .in_b_col1(skewed_b1), .in_b_col2(skewed_b2), .in_b_col3(skewed_b3),
       
       .acc00(acc00), .acc01(acc01), .acc02(acc02), .acc03(acc03),
        .acc10(acc10), .acc11(acc11), .acc12(acc12), .acc13(acc13),
        .acc20(acc20), .acc21(acc21), .acc22(acc22), .acc23(acc23),
        .acc30(acc30), .acc31(acc31), .acc32(acc32), .acc33(acc33)
    );

endmodule
