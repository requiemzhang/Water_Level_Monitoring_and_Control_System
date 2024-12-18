module Buzzer (
    input [3:0] water_level_int,    // 水位整数部分
    output reg Beep,                // 蜂鸣器报警
    input wire clk                  // 输入时钟信号
);
    
    
	 wire clk100hz; // 100Hz的时钟信号
    wire clk250hz; // 250Hz的时钟信号
    wire clk500hz; // 500Hz的时钟信号

    
    
    clk100hz u_clk_100hz (
        .clk(clk),
        .clk_out(clk100hz)
    );
    
    clk250hz u_clk_250hz (
        .clk(clk),
        .clk_out(clk250hz)
    );
    
    clk500hz u_clk_500hz (
        .clk(clk),
        .clk_out(clk500hz)
    );
    
    // 根据水位值调整蜂鸣器的频率
    always @(posedge clk) begin
        if (water_level_int <= 6) begin
            Beep <= 0;  // 安全水位，不发声
        end
        else if (water_level_int > 6 && water_level_int <= 10) begin
            if (clk100hz) begin
                Beep <= ~Beep; 
            end  
        end
        else if (water_level_int > 10 && water_level_int <= 14) begin
            if (clk250hz) begin
                Beep <= ~Beep; 
            end 
        end
        else if (water_level_int > 14) begin
            if (clk500hz) begin
                Beep <= ~Beep; 
            end  
        end
    end
endmodule
