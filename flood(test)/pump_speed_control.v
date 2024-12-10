module pump_speed_control (
    input clk,
    input btn7,              // 按键 7 控制抽水速度	
    output  reg  [1:0] pump_speed,  // 水泵速度（慢、中、快）
	 input rst
);
    wire press;
	 key1_filter_module uu_key1_filter_module(.clk(clk),
	                                          .btn(btn7),
															.ctr(press));

														  

	 initial begin
    pump_speed <= 2'd0; // 给 reg 类型变量赋初始值
    end
    
	 always @(posedge btn7) begin

            if (pump_speed == 2'd3) begin
                  pump_speed <= 2'd0;  // 速度循环：慢 -> 中 -> 快
            end
            else begin
                pump_speed <= pump_speed + 1;  // 增加速度
            end

    end

endmodule
