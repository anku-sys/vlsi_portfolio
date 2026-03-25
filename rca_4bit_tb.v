module rca_4bit_tb;

    
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    
    wire [3:0] Sum;
    wire Cout;

    
    rca_4bit uut (
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .Sum(Sum), 
        .Cout(Cout)
    );

    initial begin
         
        $dumpfile("rca.vcd");
        $dumpvars(0, rca_4bit_tb);

        // --- TEST CASE 1: Basic Addition ---
        A = 4'd5; B = 4'd3; Cin = 1'b0;
        #10; // Result  Sum = 8, Cout = 0

        // --- TEST CASE 2:   ---
        A = 4'd10; B = 4'd4; Cin = 1'b0;
        #10; // Result Sum = 14, Cout = 0

        // --- TEST CASE 3: The Overflow (15 + 1) ---
        A = 4'd15; B = 4'd1; Cin = 1'b0;
        #10; // Result Sum = 0, Cout = 1 (Carry bahar nikal gaya!)

        // --- TEST CASE 4: Carry In  ---
        A = 4'd7; B = 4'd7; Cin = 1'b1;
        #10; // Result Sum = 15, Cout = 0

        #10 $finish; 
    end

endmodule