module traffic_light_tb;

    reg clk;
    reg reset;
    reg sensor;
    wire [1:0] main_light;
    wire [1:0] side_light;

    
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .sensor(sensor),
        .main_light(main_light),
        .side_light(side_light)
    );

     
    always #5 clk = ~clk;

    initial begin
         
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, traffic_light_tb);

        //  SCENARIO 1: System Start 
        clk = 0;
        reset = 1; 
        sensor = 0; 
        #10 reset = 0; // System on

        
        #40;

        //   SCENARIO 2: (Sensor = 1) 
    
        sensor = 1; 
        
        // Wait (Main Yellow -> Main Red -> Side Green)
        #50;

        //  SCENARIO 3: (Sensor = 0) 
        
        sensor = 0;

        //  wait  (Main Green)
        #50;

      
        $finish;
    end

endmodule