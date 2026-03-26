module cla_4bit (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
);

    
    wire [3:0] G, P;
    wire [4:0] C; 

     
    assign C[0] = Cin;

     
    assign P[0] = A[0] ^ B[0];
    assign G[0] = A[0] & B[0];

    assign P[1] = A[1] ^ B[1];
    assign G[1] = A[1] & B[1];

    assign P[2] = A[2] ^ B[2];
    assign G[2] = A[2] & B[2];

    assign P[3] = A[3] ^ B[3];
    assign G[3] = A[3] & B[3];

     
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

    
    assign Sum[0] = P[0] ^ C[0];
    assign Sum[1] = P[1] ^ C[1];
    assign Sum[2] = P[2] ^ C[2];
    assign Sum[3] = P[3] ^ C[3];

    
    assign Cout = C[4];

endmodule