module mac (
    input clk,
    input rst,
    input en,          // Enable pin 
    input [7:0] a,     // 8-bit input A 
    input [7:0] b,     // 8-bit input B 
    output reg [15:0] out // 16-bit output (Accumulator)
);

    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 16'd0; //On Reset memory = zero 
        end 
        else if (en) begin
            
            
            out <= out + (a * b); 
        end
    end

endmodule