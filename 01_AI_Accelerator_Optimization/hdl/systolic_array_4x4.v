module systolic_array_4x4 #(
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH  = 20
)(
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   en,
    input  wire                   load_w,
    
    input  wire                   scan_en,
    input  wire                   scan_in,
    output wire                   scan_out,

 
    input  wire [DATA_WIDTH-1:0]  in_a_row0, in_a_row1, in_a_row2, in_a_row3,
    input  wire [DATA_WIDTH-1:0]  in_b_col0, in_b_col1, in_b_col2, in_b_col3,
    
 
    output wire [ACC_WIDTH-1:0]   acc00, acc01, acc02, acc03,
    output wire [ACC_WIDTH-1:0]   acc10, acc11, acc12, acc13,
    output wire [ACC_WIDTH-1:0]   acc20, acc21, acc22, acc23,
    output wire [ACC_WIDTH-1:0]   acc30, acc31, acc32, acc33
);

   
    wire [DATA_WIDTH-1:0] a_wire [0:3][0:4];
    wire [DATA_WIDTH-1:0] b_wire [0:4][0:3];
    wire [ACC_WIDTH-1:0]  acc_internal [0:3][0:3];
    
    wire scan_chain [0:16];

  
    assign a_wire[0][0] = in_a_row0;
    assign a_wire[1][0] = in_a_row1;
    assign a_wire[2][0] = in_a_row2;
    assign a_wire[3][0] = in_a_row3;

    assign b_wire[0][0] = in_b_col0;
    assign b_wire[0][1] = in_b_col1;
    assign b_wire[0][2] = in_b_col2;
    assign b_wire[0][3] = in_b_col3;

    assign scan_chain[0] = scan_in;
    assign scan_out      = scan_chain[16];

  
    genvar i, j;
    generate
        for (i = 0; i < 4; i = i + 1) begin : row
            for (j = 0; j < 4; j = j + 1) begin : col
                smart_pe #(DATA_WIDTH, ACC_WIDTH) pe_inst (
                    .clk(clk),
                    .rst_n(rst_n),
                    .en(en),
                    .load_w(load_w),
                    .in_a(a_wire[i][j]),
                    .in_b(b_wire[i][j]),
                  
                    .scan_en(scan_en),
                    .scan_in(scan_chain[i*4 + j]),
                    .scan_out(scan_chain[i*4 + j + 1]),
                    
                 
                    .out_a(a_wire[i][j+1]),
                    .out_b(b_wire[i+1][j]),
                    .acc(acc_internal[i][j])
                );
            end
        end
    endgenerate

   
    assign acc00 = acc_internal[0][0]; assign acc01 = acc_internal[0][1];
    assign acc02 = acc_internal[0][2]; assign acc03 = acc_internal[0][3];
    assign acc10 = acc_internal[1][0]; assign acc11 = acc_internal[1][1];
    assign acc12 = acc_internal[1][2]; assign acc13 = acc_internal[1][3];
    assign acc20 = acc_internal[2][0]; assign acc21 = acc_internal[2][1];
    assign acc22 = acc_internal[2][2]; assign acc23 = acc_internal[2][3];
    assign acc30 = acc_internal[3][0]; assign acc31 = acc_internal[3][1];
    assign acc32 = acc_internal[3][2]; assign acc33 = acc_internal[3][3];

endmodule
