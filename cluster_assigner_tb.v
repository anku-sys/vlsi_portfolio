module cluster_assigner_tb;

    reg clk, rst;
    reg [7:0] x_in, y_in, c0_x, c0_y, c1_x, c1_y;
    wire cluster_id;

    // Top module 
    cluster_assigner uut (
        .clk(clk), .rst(rst),
        .x_in(x_in), .y_in(y_in),
        .c0_x(c0_x), .c0_y(c0_y),
        .c1_x(c1_x), .c1_y(c1_y),
        .cluster_id(cluster_id)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cluster.vcd");
        $dumpvars(0, cluster_assigner_tb);

        clk = 0; rst = 1;
        
        // C0 coordinates (10, 10) 
        // C1 coordinates (100, 100) 
        c0_x = 10; c0_y = 10;
        c1_x = 100; c1_y = 100;
        x_in = 0; y_in = 0;
        
        #15 rst = 0;

        // --- INFERENCE 1: Point at (15, 15) ---
        
        @(negedge clk);
        x_in = 15; y_in = 15;
        #20;  

        // --- INFERENCE 2: Point at (95, 90) ---
        
        @(negedge clk);
        x_in = 95; y_in = 90;
        #20;

        // --- INFERENCE 3: The Tricky Middle Point (40, 40) ---
        // C0 distance: |40-10| + |40-10| = 30 + 30 = 60
        // C1 distance: |40-100| + |40-100| = 60 + 60 = 120
        
        @(negedge clk);
        x_in = 40; y_in = 40;
        #20;
        
        #30 $finish;
    end

endmodule