module manhattan_distance (
    input clk,
    input rst,
    input [7:0] x1,     // Point 1 X coordinate
    input [7:0] y1,     // Point 1 Y coordinate
    input [7:0] x2,     // Point 2 (Centroid) X coordinate
    input [7:0] y2,     // Point 2 (Centroid) Y coordinate
    output reg [15:0] distance // Final Manhattan Distance
);

    // for holding Internal wires/registers subtraction hold 
    reg [7:0] dx, dy;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            distance <= 16'd0;
        end else begin
            // Hardware Absolute Difference (MUX Logic)
            // if x1>x2 (x1-x2), else (x2-x1)
            dx = (x1 > x2) ? (x1 - x2) : (x2 - x1);
            dy = (y1 > y2) ? (y1 - y2) : (y2 - y1);

            // Final addition
            distance <= dx + dy;
        end
    end

endmodule