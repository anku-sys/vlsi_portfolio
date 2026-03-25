module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    // Sum is XOR of all inputs
    assign sum = a ^ b ^ cin;
    
    // Carry Out logic
    assign cout = (a & b) | (cin & (a ^ b));

endmodule