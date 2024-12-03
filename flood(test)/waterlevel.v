module water_level (
    input clk,                          // 时钟信号
    input [3:0] water_level_int,        // 水位信息，0-14米
	 output  reg [3:0] water_level,
    input btn0                         // 按键 bnt0 控制水泵
);	 
    wire ctr;
    wire press;
	 //btn0消抖
	 key1_filter_module m_key1_filter_module(.clk(clk),
														  .btn(btn0),
														  .stable_flag(press));
		 
	 always @(posedge clk ) begin
	     if(press)begin
	         water_level <= water_level_int;
		  end
	end
endmodule
														  