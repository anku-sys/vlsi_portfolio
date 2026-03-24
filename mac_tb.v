module mac_tb;

    reg clk, rst, en;
    reg [7:0] a, b;
    wire [15:0] out;

    
    mac uut (
        .clk(clk), .rst(rst), .en(en),
        .a(a), .b(b), .out(out)
    );

    
    always #5 clk = ~clk;

    initial begin
        
        $dumpfile("mac.vcd");
        $dumpvars(0, mac_tb);

        // --- System Start & Reset ---
        clk = 0; rst = 1; en = 0; a = 0; b = 0;
        #15 rst = 0; 

        // --- ML Dot Product Simulation ---
        
        @(negedge clk);
        en = 1;      // Engine ON
        a = 2; b = 3; 

        @(negedge clk);
        a = 4; b = 5; 

        @(negedge clk);
        a = 1; b = 10; 

        @(negedge clk);
        en = 0;      // Engine OFF 

        #20 $finish; 
    end

endmodule