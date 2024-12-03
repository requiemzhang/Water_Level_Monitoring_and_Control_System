`timescale 1ms / 1us  // 1ms 时间单位和1us精度，意味着时钟周期为1ms，频率为1kHz

module tb_DotMatrixDisplay1;

    // 输入信号
    reg clk;                 // 时钟信号
    reg rst;                 // 复位信号
    reg [3:0] water_level_int;   // 水位信息（0到15）
    reg btn0;                // 按键 0 控制水泵
    reg btn7;                // 按键 7 控制抽水速度
    

    // 输出信号
    wire [7:0] row_data;          // 行信号
    wire [7:0] red_column_data;   // 红色列信号
    wire [7:0] green_column_data; // 绿色列信号
    wire [3:0] water_level;       // 水位信号
    wire [3:0] waterlevel;        // 内部水位信号
    wire [1:0] pump_speed;        // 水泵速度
   wire stable_flag;              // 按键稳定信号

    // 实例化水泵速度控制模块
    pump_speed_control um(
        .clk(clk),
        .btn7(btn7),
        .pump_speed(pump_speed),
        .rst(rst)
    );

    // 实例化按键过滤模块
    key1_filter_module uut (
        .clk(clk),
        .reset(rst),
        .btn(btn0),
        .stable_flag(stable_flag)
    );

    // 实例化水位模块
    water_level mt (
        .clk(clk),                         
        .water_level_int(water_level_int),       
        .water_level(waterlevel),
        .btn0(btn0)
    );

    // 实例化显示模块
    DotMatrixDisplay1 ut (
        .clk(clk),
        .rst(rst),
        .water_level_int(water_level_int),
        .row_data(row_data),
        .red_column_data(red_column_data),
        .green_column_data(green_column_data),
        .water_level(water_level), // 输出水位信号
        .btn0(btn0),
        .btn7(btn7)
    );

    // 时钟生成：1kHz 时钟周期 (1ms)
    initial begin
        clk = 0;
        forever #0.5 clk = ~clk;  // 时钟周期为1ms，频率为1kHz
    end

    // 初始块：初始化信号并模拟测试场景
    initial begin
        // 初始化信号
        rst = 0;
        water_level_int = 4'b0000;  // 初始水位为 0
        btn0 = 0;
        btn7 = 0;

        // 模拟复位过程
        rst = 1;
        #10 rst = 0;

        // 模拟水位变化
        #100 water_level_int = 4'b1111;  // 水位 15
        

        // 模拟按钮 0 按下，控制水泵启动
        #100 btn0 = 1;
        #100 btn0 = 0;

        // 模拟按钮 7 按下，改变水泵速度
        #100 btn7 = 1;  // 改变水泵速度
        #100 btn7 = 0;

        // 结束仿真
        #1000 $finish;
    end

    // 输出监视：显示各个信号值
    initial begin
        $monitor("At time %t, water_level_int = %d, water_level = %d, row_data = %b, red_column_data = %b, green_column_data = %b, waterlevel = %d", 
                 $time, water_level_int, water_level, row_data, red_column_data, green_column_data, waterlevel);
    end

endmodule
