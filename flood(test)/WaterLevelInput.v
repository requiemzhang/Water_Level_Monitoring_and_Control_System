module WaterLevelInput (
    input [4:0] SW,            // 水位输入（SW4~SW0）
	 input wire clk,       // 输入时钟信号
    output reg [3:0] water_level_int,  // 水位整数部分
    output reg water_level_frac   // 水位小数部分
);

always @(posedge clk) begin
    water_level_int = SW[4:1];    // 取整数部分
    water_level_frac = SW[0];     // 取小数部分
end

endmodule
