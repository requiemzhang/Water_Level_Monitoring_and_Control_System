module DotMatrixDisplay (
    input clk,                          // 时钟信号
	 input rst,                          //复位信号
    input [3:0] water_level_int,        // 水位信息，0-14米
    output  reg [7:0] row_data,          // 行信号
    output  reg [7:0] red_column_data,   // 红色列信号
    output  reg [7:0] green_column_data // 绿色列信号

);
    wire clk1;
	
    
	 // 初始化水位显示和列数据
    initial begin
        row_data = 8'b11111111;
        red_column_data = 8'b00000000;
        green_column_data = 8'b00000000;
    end
	  
   
    
    // 实例化 2Hz 时钟信号生成模块
    clk_2hz u_clk_2hz (
        .clk(clk),
        .clk_out(clk1)
    );


	 // 根据水位值设置显示内容
    always @(posedge clk ) begin
	    // 清空显示
        row_data <= 8'b11111111;
        red_column_data <= 8'b00000000;
        green_column_data <= 8'b00000000;

        // 根据水位设置显示内容
        if (water_level_int <= 6) begin
            row_data <= 8'b11111100; // 点亮底部两行
            green_column_data <= 8'b11111111; // 所有列亮绿色
        end else if (water_level_int > 6 && water_level_int <= 8) begin
            row_data <= 8'b11111000; // 点亮底部3行
            green_column_data <= 8'b11111111;
            red_column_data <= 8'b11111111;
        end else if (water_level_int > 8 && water_level_int <= 10) begin
            row_data <= 8'b11110000; // 点亮底部4行
            green_column_data <= 8'b11111111;
            red_column_data <= 8'b11111111;
        end else if (water_level_int > 10 && water_level_int <= 12) begin
            row_data <= 8'b11100000; // 点亮底部5行
            green_column_data <= 8'b11111111;
            red_column_data <= 8'b11111111;
        end else if (water_level_int > 12 && water_level_int <= 13) begin
            row_data <= 8'b11000000; // 点亮底部6行
            red_column_data <= 8'b11111111; // 所有列亮红色
        end else if (water_level_int > 13 && water_level_int <= 14) begin
            row_data <= 8'b10000000; // 点亮底部7行
            red_column_data <= 8'b11111111;
        end else if (water_level_int > 14) begin
            row_data <= 8'b00000000; // 点亮底部8行
            red_column_data <= 8'b11111111; // 所有列亮红色
            if (clk1) begin
                red_column_data <= ~red_column_data; // 闪烁红色
            end
        end
	   end

endmodule

