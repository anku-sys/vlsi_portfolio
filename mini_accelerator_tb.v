module mini_accelerator_tb;

    reg clk, rst, start;
    wire done;
    wire [15:0] result;

    // Top module 
    mini_accelerator uut (
        .clk(clk), .rst(rst), .start(start),
        .done(done), .result(result)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("mini_accel.vcd");
        $dumpvars(0, mini_accelerator_tb);

        // System Start
        clk = 0; rst = 1; start = 0;
        #15 rst = 0;

        
        #10 start = 1;

        // Wait till 'done' flag 1  
        wait(done == 1);

        
        #20 start = 0;

        #30 $finish;
    end

endmodule