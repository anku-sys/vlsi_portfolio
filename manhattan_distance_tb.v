module manhattan_distance_tb;

    reg clk, rst;
    reg [7:0] x1, y1, x2, y2;
    wire [15:0] distance;

    
    manhattan_distance uut (
        .clk(clk), .rst(rst),
        .x1(x1), .y1(y1), .x2(x2), .y2(y2),
        .distance(distance)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("manhattan.vcd");
        $dumpvars(0, manhattan_distance_tb);

        // System Start
        clk = 0; rst = 1;
        x1 = 0; y1 = 0; x2 = 0; y2 = 0;
        #15 rst = 0;

        // --- TEST CASE 1 ---
        @(negedge clk);
        x1 = 10; y1 = 10;
        x2 = 15; y2 = 20; 
        // Expected Math: |10-15| + |10-20| = 5 + 10 = 15

        // --- TEST CASE 2 ---
        @(negedge clk);
        x1 = 100; y1 = 50;
        x2 = 20;  y2 = 80; 
        // Expected Math: |100-20| + |50-80| = 80 + 30 = 110

        // --- TEST CASE 3 (Extreme values) ---
        @(negedge clk);
        x1 = 255; y1 = 0;
        x2 = 0;   y2 = 255; 
        // Expected Math: 255 + 255 = 510

        #20 $finish;
    end

endmodule