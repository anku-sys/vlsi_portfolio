module fifo (
    input clk,
    input rst,
    input wr_en,          // Write Enable 
    input rd_en,          // Read Enable 
    input [7:0] data_in,  // 8-bit 
    output reg [7:0] data_out, // 8-bit 
    output full,          // Flag: FIFO full
    output empty          // Flag: FIFO empty
);

    // FIFO Memory (16 locations of 8-bit width)
    reg [7:0] mem [0:15];

    // Pointers and Counter
    reg [3:0] wr_ptr; // Write pointer 
    reg [3:0] rd_ptr; // Read pointer 
    reg [4:0] count; 

    // Flags assignment
    assign empty = (count == 0);
    assign full  = (count == 16);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            data_out <= 0;
        end else begin
            
            // Scenario 1: only write
            if (wr_en && !rd_en && !full) begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end
            
            // Scenario 2: only Read
            else if (rd_en && !wr_en && !empty) begin
                data_out <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end
            
            // Scenario 3: Read and Write together
            else if (wr_en && rd_en && !full && !empty) begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1;
                
                data_out <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                // Count will remain same cuz one data in and one data out at a time
            end
            
        end
    end

endmodule