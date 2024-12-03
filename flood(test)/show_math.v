module show_math (
    input [3:0] water_level_int,    // 水位整数部分
    input water_level_frac,         // 水位小数部分
	 input rst,  //复位信号
    input wire clk,       // 输入时钟信号
    output reg [6:0] seg, // 七段数码管段位输出
	 output reg seg_dot,
    output reg [7:0] cat,  // 位选控制信号
	 input btn7                          // 按键 7 控制抽水速度
);
    
	 reg [3:0] cnt0; // 小数位计数值
	 reg [3:0] cnt1; // 个位计数值
    reg [3:0] cnt2; // 十位计数值
    reg [3:0] bin;       // 当前显示的数值
    reg [2:0] select;          // 位选信号，用于在个位和十位之间切换
	 wire [1:0] pump_speed;  // 水泵速度（慢、中、快）
    
	 
	  // 实例化水泵速度控制模块
    pump_speed_control u_pump_speed_control (
        .btn7(btn7),
        .pump_speed(pump_speed),
		  .rst(rst)
    );
	 
	 //定义小数部分
	 always @(*) begin
       if(water_level_frac==1) begin
		 cnt0<=4'd5;
		 end
		 else begin
		 cnt0<=4'd0;
		 end
    end
	 
	 
	 
	// 定义整数部分
    always @(*) begin
        cnt2 = water_level_int / 10;  // 十位数
        cnt1 = water_level_int % 10;  // 个位数
    end
	 
	 
	 
	 
	 // 数码管位选控制
    always @(posedge clk ) begin
        if (select==3'b100) begin
            select<=3'b000;
        end
        else begin
            select <= select+2'b01;
            if (select == 3'b001) begin
                cat <= 8'b1111_1101;//cat[0]是左边第一个
                bin <= cnt1;
					 seg_dot<=1;
            end
            else if (select==3'b010) begin
                cat <= 8'b1111_1011;
                bin <= cnt2;
					 seg_dot<=0;
            end
				else if (select == 3'b000) begin
                cat <= 8'b1111_1110;
                bin <= cnt0;
					 seg_dot<=0;
            end
				else if (select == 3'b011) begin
                cat <= 8'b0111_1111;
                bin <= pump_speed ;
					 seg_dot<=0;
            end
        end
    end
 
 
 
 // 七段数码管译码
    always @(bin) begin
        case (bin)
            4'd0: seg = 7'b1111110;//最高位seg[6]是a其次按表往下
            4'd1: seg = 7'b0110000;
            4'd2: seg = 7'b1101101;
            4'd3: seg = 7'b1111001;
            4'd4: seg = 7'b0110011;
            4'd5: seg = 7'b1011011;
            4'd6: seg = 7'b1011111;
            4'd7: seg = 7'b1110000;
            4'd8: seg = 7'b1111111;
            4'd9: seg = 7'b1111011;
            default: seg = 7'b0000000;
        endcase
    end

endmodule



    