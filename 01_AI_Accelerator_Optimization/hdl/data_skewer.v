module data_skewer #(
    parameter DATA_WIDTH = 8
)(
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   en,
    input  wire [DATA_WIDTH-1:0]  in0, in1, in2, in3,
    output wire [DATA_WIDTH-1:0]  out0, out1, out2, out3
);

    reg [DATA_WIDTH-1:0] delay1_r1;
    
    reg [DATA_WIDTH-1:0] delay1_r2, delay2_r2;
    
    reg [DATA_WIDTH-1:0] delay1_r3, delay2_r3, delay3_r3;

    assign out0 = in0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            delay1_r1 <= {DATA_WIDTH{1'b0}};
            delay1_r2 <= {DATA_WIDTH{1'b0}}; delay2_r2 <= {DATA_WIDTH{1'b0}};
            delay1_r3 <= {DATA_WIDTH{1'b0}}; delay2_r3 <= {DATA_WIDTH{1'b0}}; delay3_r3 <= {DATA_WIDTH{1'b0}};
        end else if (en) begin
            delay1_r1 <= in1;
            
            delay1_r2 <= in2;
            delay2_r2 <= delay1_r2;
            
            delay1_r3 <= in3;
            delay2_r3 <= delay1_r3;
            delay3_r3 <= delay2_r3;
        end
    end

    assign out1 = delay1_r1;
    assign out2 = delay2_r2;
    assign out3 = delay3_r3;

endmodule
