module fifo_tb;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [7:0] data_in;
    
    wire [7:0] data_out;
    wire full;
    wire empty;

     
    fifo uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    
    always #5 clk = ~clk;

    initial begin
        
        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_tb);

        // --- SCENARIO 1: System Reset ---
        clk = 0; 
        rst = 1;
        wr_en = 0; 
        rd_en = 0; 
        data_in = 0;
        
        #15; 
        rst = 0; 

        // --- SCENARIO 2: ---
        repeat(16) begin
            @(negedge clk); 
            wr_en = 1;
            data_in = data_in + 8'h11; 
        end
        
        @(negedge clk);
        wr_en = 0; 
        
        #20; 

        // --- SCENARIO 3:---
        repeat(16) begin
            @(negedge clk);
            rd_en = 1; 
        end
        
        @(negedge clk);
        rd_en = 0; 
        
        
        #40; 
        $finish; 
    end

endmodule
