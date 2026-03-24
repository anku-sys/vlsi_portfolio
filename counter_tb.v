module counter_tb;

    reg clk;
    reg reset;
    wire [3:0] count;

 
    counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

 
    always #5 clk = ~clk;

    initial begin
     
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_tb);

     
        clk = 0;
        reset = 1;

      
        #10 reset = 0;

     
        #200;
        
        $finish; // Simulation khatam
    end

endmodule