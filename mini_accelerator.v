module mini_accelerator (
    input clk,
    input rst,
    input start,                 
    output reg done,             
    output wire [15:0] result    
);

    // FSM States
    parameter IDLE   = 3'b000;
    parameter CALC_1 = 3'b001;
    parameter CALC_2 = 3'b010;
    parameter CALC_3 = 3'b011;
    parameter FINISH = 3'b100;

    reg [2:0] state, next_state;

    // MAC Unit control signals
    reg mac_en;
    reg mac_rst;
    reg [7:0] a_val, b_val;

    // MAC Unit 'instantiate' 
    mac math_engine (
        .clk(clk),
        .rst(mac_rst),
        .en(mac_en),
        .a(a_val),
        .b(b_val),
        .out(result)
    );

    // Block 1: State Memory
    always @(posedge clk or posedge rst) begin
        if (rst) state <= IDLE;
        else     state <= next_state;
    end

    // Block 2: FSM Logic (Brain)
    always @(*) begin
        // Default signals
        next_state = state;
        mac_en = 0;
        mac_rst = 0;
        done = 0;
        a_val = 8'd0; b_val = 8'd0;

        case(state)
            IDLE: begin
                mac_rst = 1; // MAC memory clear 
                if (start) next_state = CALC_1; // Start 
            end

            CALC_1: begin
                mac_en = 1;
                a_val = 8'd2; b_val = 8'd3; // Step 1: 2 * 3
                next_state = CALC_2;
            end

            CALC_2: begin
                mac_en = 1;
                a_val = 8'd4; b_val = 8'd5; // Step 2: 4 * 5
                next_state = CALC_3;
            end

            CALC_3: begin
                mac_en = 1;
                a_val = 8'd1; b_val = 8'd10; // Step 3: 1 * 10
                next_state = FINISH;
            end

            FINISH: begin
                done = 1; 
                if (!start) next_state = IDLE; 
            end
        endcase
    end

endmodule