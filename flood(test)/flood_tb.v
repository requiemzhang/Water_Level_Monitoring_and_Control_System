module flood_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [4:0] SW;
    reg btn0;
    reg btn7;
    
    // Outputs
    wire [7:0] row_data;
    wire [7:0] red_column_data;
    wire [7:0] green_column_data;
    wire Beep;
    wire [6:0] seg;
    wire [7:0] cat;
    wire seg_dot;

    // Instantiate the flood module
    flood uut (
        .clk(clk),
        .rst(rst),
        .SW(SW),
        .row_data(row_data),
        .red_column_data(red_column_data),
        .green_column_data(green_column_data),
        .Beep(Beep),
        .seg(seg),
        .cat(cat),
        .seg_dot(seg_dot),
        .btn0(btn0),
        .btn7(btn7)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Clock period of 10 time units
    end

    // Stimulus generation
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;
        SW = 5'b00000;
        btn0 = 0;
        btn7 = 0;
        
        // Apply reset
        #10 rst = 1; // Apply reset for 10 time units
        #10 rst = 0; // Deassert reset
        
        // Test: Simulate water level increase and button press events
        
        // Set water level to 0
        #20 SW = 5'b00000;
        #20 SW = 5'b00001; // Water level 1
        
        // Test: Pressing btn0 (to control water pump)
        #200 btn0 = 1;  // Simulate pressing btn0
        #200 btn0 = 0;  // Simulate releasing btn0
        
        // Test: Set water level to 12 (borderline for display change)
        #20 SW = 5'b01100; // Water level 12
        #20 SW = 5'b01101; // Water level 13
        
        // Test: Pressing btn7 (to control pump speed)
        #200 btn7 = 1;  // Simulate pressing btn7
        #200 btn7 = 0;  // Simulate releasing btn7
        
        // Set water level to 15 (maximum)
        #20 SW = 5'b01111; // Water level 15
        
        // Test: Pressing btn0 to control water pump
        #200 btn0 = 1;  // Simulate pressing btn0
        #200 btn0 = 0;  // Simulate releasing btn0

        // Test: Reset water level to 0
        #20 SW = 5'b00000; // Water level 0
        
        // Test: Apply reset
        #20 rst = 1; // Apply reset
        #10 rst = 0; // Deassert reset
        
        // Finish simulation
        #100 $finish;
    end

    // Monitoring outputs (optional)
    initial begin
        $monitor("At time %t, Water Level = %d, Row Data = %b, Red Column Data = %b, Green Column Data = %b, Beep = %b, Seg = %b, Cat = %b, Seg Dot = %b",
                 $time, SW, row_data, red_column_data, green_column_data, Beep, seg, cat, seg_dot);
    end

endmodule
