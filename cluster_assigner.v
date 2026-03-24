module cluster_assigner (
    input clk,
    input rst,
    input [7:0] x_in, y_in,        
    input [7:0] c0_x, c0_y,       // Centroid 0 location
    input [7:0] c1_x, c1_y,       // Centroid 1 location
    output reg cluster_id         // Final result: 0 (Cluster 0) or 1 (Cluster 1)
);

    wire [15:0] dist0, dist1;

    // --- ENGINE 1: Distance from Centroid 0 ---
    manhattan_distance calc_c0 (
        .clk(clk), .rst(rst),
        .x1(x_in), .y1(y_in), .x2(c0_x), .y2(c0_y),
        .distance(dist0)
    );

    // --- ENGINE 2: Distance from Centroid 1 ---
    manhattan_distance calc_c1 (
        .clk(clk), .rst(rst),
        .x1(x_in), .y1(y_in), .x2(c1_x), .y2(c1_y),
        .distance(dist1)
    );

    // --- PIPELINE STAGE: The Comparator ---
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cluster_id <= 1'b0;
        end else begin
            
            if (dist0 < dist1) begin
                cluster_id <= 1'b0;
            end else begin
                cluster_id <= 1'b1;
            end
        end
    end

endmodule 