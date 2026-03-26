module alu_8bit_tb;

    reg [7:0] A;
    reg [7:0] B;
    reg [1:0] Opcode;
    wire [15:0] Result;

    // ALU ko instantiate karo
    alu_8bit uut (
        .A(A), .B(B), .Opcode(Opcode), .Result(Result)
    );

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_8bit_tb);

        // Test 1: Addition (Opcode 00)
        A = 8'd10; B = 8'd5; Opcode = 2'b00; 
        #10; // Expected: 15

        // Test 2: Subtraction (Opcode 01)
        A = 8'd20; B = 8'd8; Opcode = 2'b01; 
        #10; // Expected: 12

        // Test 3: Multiplication (Opcode 10)
        A = 8'd15; B = 8'd4; Opcode = 2'b10; 
        #10; // Expected: 60

        // Test 4: Division (Opcode 11)
        A = 8'd50; B = 8'd5; Opcode = 2'b11; 
        #10; // Expected: 10

        // Test 5: Divide by Zero Exception!
        A = 8'd50; B = 8'd0; Opcode = 2'b11; 
        #10; // Expected: 65535 (FFFF)

        #10 $finish;
    end

endmodule