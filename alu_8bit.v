module alu_8bit (
    input [7:0] A,          // 8-bit Input A
    input [7:0] B,          // 8-bit Input B
    input [1:0] Opcode,     // 2-bit Operation Code
    output reg [15:0] Result // 16-bit Output  
);

    always @(*) begin
        case (Opcode)
            2'b00: Result = A + B;       // ADD
            2'b01: Result = A - B;       // SUBTRACT
            2'b10: Result = A * B;       // MULTIPLY
            2'b11: begin                 // DIVIDE
                if (B != 0) 
                    Result = A / B;
                else 
                    Result = 16'hFFFF;   // Error condition (Divide by Zero)  all bits 1
            end
            default: Result = 16'd0;
        endcase
    end

endmodule