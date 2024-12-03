module DotMatrixDisplay1 (
    input clk,                          // 时钟信号
	 input rst,                          //复位信号
    input [3:0] water_level_int,        // 水位信息，0-15米
    output  reg [7:0] row_data,          // 行信号
    output  reg [7:0] red_column_data,   // 红色列信号
    output  reg [7:0] green_column_data, // 绿色列信号
    input btn0,                         // 按键 bnt0 控制水泵
    input btn7,                          // 按键 7 控制抽水速度
	 output reg [3:0] water_level      // 输出水位信号
);	 
	 
	 
	 wire clk1;
	 wire ctr;
    wire [3:0] waterlevel;  // 水位，存储水位信息
	 wire [1:0] pump_speed;  // 水泵速度（慢、中、快）
    

	 reg [2:0] current_row;   // 当前行索引
    
    // 示例“水泵抽水”动画帧数据
    reg [7:0] red_frames [0:9][0:7]; 
    reg [7:0] green_frames [0:9][0:7]; 
	 
	 wire press;
	 key1_filter_module m_key1_filter_module(.clk(clk),
	                                          .btn(btn0),
															.stable_flag(press));

	 
	 pump_speed_control e_pump_speed_control(.btn7(btn7),
	                                         .pump_speed(pump_speed),
														  .rst(rst));
	 
	
    
	 //取出一个按下按键时water_level_int的值并保持不变													  
	 water_level u_waterlevel(.clk(clk),
	                         .water_level_int(water_level_int),   
									 .water_level(waterlevel),
									 .btn0(btn0));

	 
	 // 实例化 1Hz 时钟信号生成模块
    clk_1hz u_clk_1hz (
        .clk(clk),
        .clk_out(clk1)
    );

	 
	 // 初始化水位显示和列数据
    initial begin
        row_data = 8'b11111111;
        red_column_data = 8'b00000000;
        green_column_data = 8'b00000000;
  
		  
		  
       // 初始化动画帧数据

        // 第1帧：15m
        red_frames[0][7] = 8'b00111111; green_frames[0][7] = 8'b11000000;
        red_frames[0][6] = 8'b00111111; green_frames[0][6] = 8'b11000000; 
        red_frames[0][5] = 8'b00111111; green_frames[0][5] = 8'b11000000; 
        red_frames[0][4] = 8'b00111111; green_frames[0][4] = 8'b11000000; 
        red_frames[0][3] = 8'b00111111; green_frames[0][3] = 8'b11000000; 
        red_frames[0][2] = 8'b00111111; green_frames[0][2] = 8'b11000000; 
        red_frames[0][1] = 8'b00111111; green_frames[0][1] = 8'b11000000; 
        red_frames[0][0] = 8'b00001111; green_frames[0][0] = 8'b11110000; 

        // 第2帧：14m
        red_frames[1][7] = 8'b00000011; green_frames[1][7] = 8'b11000000;
        red_frames[1][6] = 8'b00111111; green_frames[1][6] = 8'b11000000; 
        red_frames[1][5] = 8'b00111111; green_frames[1][5] = 8'b11000000; 
        red_frames[1][4] = 8'b00111111; green_frames[1][4] = 8'b11000000; 
        red_frames[1][3] = 8'b00111111; green_frames[1][3] = 8'b11000000; 
        red_frames[1][2] = 8'b00111111; green_frames[1][2] = 8'b11000000; 
        red_frames[1][1] = 8'b00111111; green_frames[1][1] = 8'b11000000; 
        red_frames[1][0] = 8'b00001111; green_frames[1][0] = 8'b11110000; 


        // 第3帧：13m
        red_frames[2][7] = 8'b00000000; green_frames[2][7] = 8'b11000000;
        red_frames[2][6] = 8'b00001111; green_frames[2][6] = 8'b11000000; 
        red_frames[2][5] = 8'b00111111; green_frames[2][5] = 8'b11000000; 
        red_frames[2][4] = 8'b00111111; green_frames[2][4] = 8'b11000000; 
        red_frames[2][3] = 8'b00111111; green_frames[2][3] = 8'b11000000; 
        red_frames[2][2] = 8'b00111111; green_frames[2][2] = 8'b11000000; 
        red_frames[2][1] = 8'b00111111; green_frames[2][1] = 8'b11000000; 
        red_frames[2][0] = 8'b00001111; green_frames[2][0] = 8'b11110000; 

        // 第4帧：12m
        red_frames[3][7] = 8'b00000000; green_frames[3][7] = 8'b11000000;
        red_frames[3][6] = 8'b00000000; green_frames[3][6] = 8'b11000000; 
        red_frames[3][5] = 8'b00111111; green_frames[3][5] = 8'b11000000; 
        red_frames[3][4] = 8'b00111111; green_frames[3][4] = 8'b11000000; 
        red_frames[3][3] = 8'b00111111; green_frames[3][3] = 8'b11000000; 
        red_frames[3][2] = 8'b00111111; green_frames[3][2] = 8'b11000000; 
        red_frames[3][1] = 8'b00111111; green_frames[3][1] = 8'b11000000; 
        red_frames[3][0] = 8'b00001111; green_frames[3][0] = 8'b11110000; 
		   // 第5帧：11m
        red_frames[4][7] = 8'b00000000; green_frames[4][7] = 8'b11000000;
        red_frames[4][6] = 8'b00000000; green_frames[4][6] = 8'b11000000; 
        red_frames[4][5] = 8'b00000011; green_frames[4][5] = 8'b11000000; 
        red_frames[4][4] = 8'b00111111; green_frames[4][4] = 8'b11000000; 
        red_frames[4][3] = 8'b00111111; green_frames[4][3] = 8'b11000000; 
        red_frames[4][2] = 8'b00111111; green_frames[4][2] = 8'b11000000; 
        red_frames[4][1] = 8'b00111111; green_frames[4][1] = 8'b11000000; 
        red_frames[4][0] = 8'b00001111; green_frames[4][0] = 8'b11110000; 
		  // 第6帧：10m
        red_frames[5][7] = 8'b00000000; green_frames[5][7] = 8'b11000000;
        red_frames[5][6] = 8'b00000000; green_frames[5][6] = 8'b11000000; 
        red_frames[5][5] = 8'b00000000; green_frames[5][5] = 8'b11000000; 
        red_frames[5][4] = 8'b00001111; green_frames[5][4] = 8'b11000000; 
        red_frames[5][3] = 8'b00111111; green_frames[5][3] = 8'b11000000; 
        red_frames[5][2] = 8'b00111111; green_frames[5][2] = 8'b11000000; 
        red_frames[5][1] = 8'b00111111; green_frames[5][1] = 8'b11000000; 
        red_frames[5][0] = 8'b00001111; green_frames[5][0] = 8'b11110000; 
		  // 第7帧：9m
        red_frames[6][7] = 8'b00000000; green_frames[6][7] = 8'b11000000;
        red_frames[6][6] = 8'b00000000; green_frames[6][6] = 8'b11000000; 
        red_frames[6][5] = 8'b00000000; green_frames[6][5] = 8'b11000000; 
        red_frames[6][4] = 8'b00000000; green_frames[6][4] = 8'b11000000; 
        red_frames[6][3] = 8'b00111111; green_frames[6][3] = 8'b11111111; 
        red_frames[6][2] = 8'b00111111; green_frames[6][2] = 8'b11111111; 
        red_frames[6][1] = 8'b00111111; green_frames[6][1] = 8'b11111111; 
        red_frames[6][0] = 8'b00001111; green_frames[6][0] = 8'b11111111; 
		  // 第8帧：8m
        red_frames[7][7] = 8'b00000000; green_frames[7][7] = 8'b11000000;
        red_frames[7][6] = 8'b00000000; green_frames[7][6] = 8'b11000000; 
        red_frames[7][5] = 8'b00000000; green_frames[7][5] = 8'b11000000; 
        red_frames[7][4] = 8'b00000000; green_frames[7][4] = 8'b11000000; 
        red_frames[7][3] = 8'b00000011; green_frames[7][3] = 8'b11000011; 
        red_frames[7][2] = 8'b00111111; green_frames[7][2] = 8'b11111111; 
        red_frames[7][1] = 8'b00111111; green_frames[7][1] = 8'b11111111; 
        red_frames[7][0] = 8'b00001111; green_frames[7][0] = 8'b11111111; 
		   // 第9帧：7m
        red_frames[8][7] = 8'b00000000; green_frames[8][7] = 8'b11000000;
        red_frames[8][6] = 8'b00000000; green_frames[8][6] = 8'b11000000; 
        red_frames[8][5] = 8'b00000000; green_frames[8][5] = 8'b11000000; 
        red_frames[8][4] = 8'b00000000; green_frames[8][4] = 8'b11000000; 
        red_frames[8][3] = 8'b00000000; green_frames[8][3] = 8'b11000000; 
        red_frames[8][2] = 8'b00001111; green_frames[8][2] = 8'b11001111; 
        red_frames[8][1] = 8'b00111111; green_frames[8][1] = 8'b11111111; 
        red_frames[8][0] = 8'b00001111; green_frames[8][0] = 8'b11111111; 
		  // 第10帧：6m
        red_frames[9][7] = 8'b00000000; green_frames[9][7] = 8'b11000000;
        red_frames[9][6] = 8'b00000000; green_frames[9][6] = 8'b11000000; 
        red_frames[9][5] = 8'b00000000; green_frames[9][5] = 8'b11000000; 
        red_frames[9][4] = 8'b00000000; green_frames[9][4] = 8'b11000000; 
        red_frames[9][3] = 8'b00000000; green_frames[9][3] = 8'b11000000; 
        red_frames[9][2] = 8'b00000000; green_frames[9][2] = 8'b11000000; 
        red_frames[9][1] = 8'b00000000; green_frames[9][1] = 8'b11111111; 
        red_frames[9][0] = 8'b00000000; green_frames[9][0] = 8'b11111111; 
    end
	
	
	
	
	 always@(posedge clk ) begin
	    if(btn0) begin
		    water_level<=waterlevel;
		 end
		 else if(clk1) begin  
		    if ((water_level - 6)> pump_speed)begin
              water_level <= water_level - pump_speed;
		    end
          else begin
             water_level <= 6; //安全水位
		    end
		 end
  	end
	
	
	 
	 
	always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_row <= 0;
        end else begin
            // 逐行扫描
            current_row <= current_row + 1;
            if (current_row == 7)begin
				    current_row <= 0;
				end
		 end		
           
    end
	
	 always @(posedge clk ) begin
	     row_data <= ~(1 << current_row);
		  if(water_level >=15) begin
	              red_column_data <= red_frames[0][current_row];
                 green_column_data <= green_frames[0][current_row];
        end
		  else if((water_level >=14)&&(water_level < 15)) begin
	              red_column_data <= red_frames[1][current_row];
                 green_column_data <= green_frames[1][current_row];
        end
		  else if((water_level >=13)&&(water_level < 14)) begin
	              red_column_data <= red_frames[2][current_row];
                 green_column_data <= green_frames[2][current_row];
        end
		  else if((water_level >=12)&&(water_level < 13)) begin
	              red_column_data <= red_frames[3][current_row];
                 green_column_data <= green_frames[3][current_row];
        end
		  else if((water_level >=11)&&(water_level < 12)) begin
	              red_column_data <= red_frames[4][current_row];
                 green_column_data <= green_frames[4][current_row];
        end
		  else if((water_level >=10)&&(water_level < 11)) begin
	              red_column_data <= red_frames[5][current_row];
                 green_column_data <= green_frames[5][current_row];
        end
		  else if((water_level >=9)&&(water_level < 10)) begin
	              red_column_data <= red_frames[6][current_row];
                 green_column_data <= green_frames[6][current_row];
        end
		  else if((water_level >=8)&&(water_level < 9)) begin
	              red_column_data <= red_frames[7][current_row];
                 green_column_data <= green_frames[7][current_row];
        end
	     else if((water_level >=7)&&(water_level < 8)) begin
	              red_column_data <= red_frames[8][current_row];
                 green_column_data <= green_frames[8][current_row];
        end
		  else if((water_level >=6)&&(water_level < 7)) begin
	              red_column_data <= red_frames[9][current_row];
                 green_column_data <= green_frames[9][current_row];
        end
		 
     end
	
	
	
	
	
	
	
endmodule
