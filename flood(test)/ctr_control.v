module ctr_control(
    input clk,
	 input rst,
	 input btn0,
	 input btn7,
	 output reg ctr
);

    wire clk1;
    wire [3:0] waterlevel;  // 水位，存储水位信息
	 wire [1:0] pump_speed;  // 水泵速度（慢、中、快）
    reg [3:0] water_level;
	 wire press;
	 key1_filter_module uu_key1_filter_module(.clk(clk),
	                                          .btn(btn0),
															.stable_flag(press));
	 
	 pump_speed_control e_pump_speed_control(
        .btn7(btn7),
        .pump_speed(pump_speed),
        .rst(rst)
    );
    
    // 实例化水位模块
    water_level u_waterlevel(
        .clk(clk),
        .water_level_int(water_level),  // 水位传递
        .water_level(waterlevel),
        .btn0(btn0)
    );



	
	 // 实例化 1Hz 时钟信号生成模块
    clk_1hz u_clk_1hz (
        .clk(clk),
        .clk_out(clk1)
    );
     								 
									 
   initial begin
	water_level <= 4'd15;
	ctr<=1'b0;
	end

	 always@(posedge clk ) begin
	    if(btn0) begin
		    water_level<=waterlevel;
		 end
		 else if(clk1) begin  
		    if ((water_level-6)> pump_speed)begin
              water_level <= water_level - pump_speed;
				  ctr<=1'b1;
		    end
          else begin
             water_level <= 6; //安全水位
				 ctr<=1'b0;
		    end
		 end
  	end
	 
   

endmodule