module traffic_light (
    input clk,
    input reset,
    input sensor,               
    output reg [1:0] main_light,  
    output reg [1:0] side_light   
);

     
    parameter S0_MAIN_GREEN  = 2'b00;
    parameter S1_MAIN_YELLOW = 2'b01;
    parameter S2_SIDE_GREEN  = 2'b10;
    parameter S3_SIDE_YELLOW = 2'b11;

     
    reg [1:0] current_state, next_state;

     
     
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0_MAIN_GREEN;  
        else
            current_state <= next_state;     
    end

     
     
    always @(*) begin
         
        main_light = 2'b00; 
        side_light = 2'b00;
        next_state = current_state; 

        case(current_state)
            S0_MAIN_GREEN: begin
                main_light = 2'b10; // Main Green (10)
                side_light = 2'b00; // Side Red (00)
                if (sensor) 
                    next_state = S1_MAIN_YELLOW;  
            end

            S1_MAIN_YELLOW: begin
                main_light = 2'b01; // Main Yellow (01)
                side_light = 2'b00; // Side Red (00)
                next_state = S2_SIDE_GREEN;  
            end

            S2_SIDE_GREEN: begin
                main_light = 2'b00; // Main Red (00)
                side_light = 2'b10; // Side Green (10)
                if (!sensor) 
                    next_state = S3_SIDE_YELLOW; 
            end

            S3_SIDE_YELLOW: begin
                main_light = 2'b00; // Main Red (00)
                side_light = 2'b01; // Side Yellow (01)
                next_state = S0_MAIN_GREEN;  
            end
        endcase
    end

endmodule