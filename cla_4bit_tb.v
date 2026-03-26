module cla_4bit_tb;

    reg [3:0] A;
    reg [3:0] B;
    reg Cin;
    wire [3:0] Sum;
    wire Cout;


    cla_4bit uut (
        .A(A), .B(B), .Cin(Cin), 
        .Sum(Sum), .Cout(Cout)
    );

    initial begin
        $dumpfile("cla.vcd");
        $dumpvars(0, cla_4bit_tb);

        // Test 1: Basic addition
        A = 4'd5; B = 4'd3; Cin = 1'b0;
        #10;

        // Test 2: The Overflow (15 + 1)
        A = 4'd15; B = 4'd1; Cin = 1'b0;
        #10;

        // Test 3: High numbers with carry in
        A = 4'd10; B = 4'd10; Cin = 1'b1; // 10 + 10 + 1 = 21 (Sum = 5, Cout = 1)
        #10;

        $finish;
    end
endmodule