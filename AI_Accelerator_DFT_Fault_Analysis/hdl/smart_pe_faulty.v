module smart_pe_faulty #(
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH  = 20
)(
    input  wire                   clk,     
    input  wire                   rst_n,   
    input  wire                   en,             
    input  wire                   load_w,  
    input  wire [DATA_WIDTH-1:0]  in_a,    
    input  wire [DATA_WIDTH-1:0]  in_b,    
    input  wire                   scan_en, 
    input  wire                   scan_in, 
    output wire                   scan_out,

    output reg  [DATA_WIDTH-1:0]  out_a,
    output reg  [DATA_WIDTH-1:0]  out_b, 
    output reg  [ACC_WIDTH-1:0]   acc      
);

    reg [DATA_WIDTH-1:0] weight_reg;
    wire [15:0] mult_result;
    
    wire [ACC_WIDTH-1:0] next_acc_correct;

  
    wire is_zero = (in_a == {DATA_WIDTH{1'b0}}) || (weight_reg == {DATA_WIDTH{1'b0}} && !load_w);
    assign mult_result = is_zero ? 16'b0 : (in_a * weight_reg);


    assign next_acc_correct = acc + { {4{1'b0}}, mult_result };

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc      <= {ACC_WIDTH{1'b0}};
            out_a    <= {DATA_WIDTH{1'b0}};
            out_b    <= {DATA_WIDTH{1'b0}}; 
            weight_reg <= {DATA_WIDTH{1'b0}};
        end else if (scan_en) begin
         
            weight_reg <= {weight_reg[DATA_WIDTH-2:0], scan_in}; 
        end else if (en) begin
            if (load_w) begin
                weight_reg <= in_b;
                out_b      <= in_b; 
            end else begin
       
               acc <= {next_acc_correct[19:6], 1'b1, next_acc_correct[4:0]};
             
                out_a <= in_a;     
                out_b <= in_b;           
            end
        end
    end

    assign scan_out = weight_reg[DATA_WIDTH-1]; 

endmodule
