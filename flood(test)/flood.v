module flood(
    input clk,                          // 时钟信号
	 input rst,             //复位信号
	 input [4:0] SW,            // 水位输入（SW4~SW0）
    output reg [7:0] row_data,          // 行信号
    output reg [7:0] red_column_data,   // 红色列信号
    output reg [7:0] green_column_data,  // 绿色列信号
	 output  Beep,               // 蜂鸣器报警
	 output  [6:0] seg, // 七段数码管段位输出
    output  [7:0] cat,  // 位选控制信号
	 output seg_dot,
	 input btn0,                         // 按键 bnt0 控制水泵
    input btn7                          // 按键 7 控制抽水速度
	 
);
    wire [3:0] water_level_int;        // 水位信息，0-14米
	 wire water_level_frac;   // 水位小数部分
	 wire [7:0] row_data1;
	 wire [7:0] row_data2;
	 wire [7:0] green_column_data1;
	 wire [7:0] green_column_data2;
	 wire [7:0] red_column_data1;
	 wire [7:0] red_column_data2;
	 wire ctr;

	 
	 
	 
	 
	 WaterLevelInput u_WaterLevelInput(.SW(SW),
	                                   .clk(clk),
												  .water_level_int(water_level_int),
												  .water_level_frac(water_level_frac));
	  
	  
	  
	 
	 DotMatrixDisplay u_DotMatrixDisplay (.clk(clk),
	                                       .water_level_int(water_level_int),
														.row_data(row_data1),
														.red_column_data(red_column_data1),
														.green_column_data(green_column_data1)
);
		
	
										
    
	 show_math u_show_math(.water_level_int(water_level_int),    
                          .water_level_frac(water_level_frac),       
                          .clk(clk),   
                          .seg(seg), 
                          .cat(cat),
								  .seg_dot(seg_dot),
								  .btn7(btn7),
								  .rst(rst),
								  .btn0(btn0)); 
								 
	
	 Buzzer u_Buzzer(.water_level_int(water_level_int),
                    .Beep(Beep),
						  .clk(clk)); 
						 
	 DotMatrixDisplay1 u_DotMatrixDisplay1 (.clk(clk),
	                                       .water_level_int(water_level_int),
														.row_data(row_data2),
														.red_column_data(red_column_data2),
														.green_column_data(green_column_data2),
														.btn0(btn0),
														.btn7(btn7),
	  												   .rst(rst));	
														
	 ctr_control	u_ctr_control(.clk(clk),
		                          .rst(rst),
										  .btn0(btn0),
										  .btn7(btn7),
										  .ctr(ctr));											
														
 	

     always @(posedge clk ) begin
	      if((ctr &(water_level_int >= 12)))begin
	           row_data <=  row_data2;  
              red_column_data <= red_column_data2;
              green_column_data <=  green_column_data2;
         end
	      else begin
			 row_data <=  row_data1;  
          red_column_data <= red_column_data1;
          green_column_data <=  green_column_data1; 
			
		    end
	end								
	
		
endmodule