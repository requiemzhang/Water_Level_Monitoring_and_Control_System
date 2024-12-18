`timescale 1ms / 1us

module key1_filter_tb;

    // 测试平台信号定义
    reg clk;             // 时钟信号
    reg reset;           // 异步复位信号
    reg btn;             // 按钮输入
    wire stable_flag;    // 持续稳定信号
    wire press;          // 单周期脉冲信号

    // 实例化 key1_filter_module
    key1_filter_module uut (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .stable_flag(stable_flag),
        .press(press)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #0.5 clk = ~clk;  // 1kHz 时钟周期
    end

    // 仿真过程
    initial begin
        // 初始状态
        reset = 1;
        btn = 0;
        #10 reset = 0; // 释放复位信号
        
        // 模拟按钮按下
        #10 btn = 1;  // 按钮按下
        #100 btn = 0; // 按钮释放

        // 模拟按钮持续按下
        #20 btn = 1;  // 按钮再次按下
        #100 btn = 0; // 按钮释放

        // 完成仿真
        #50 $finish;
    end

    // 显示波形
    initial begin
        $dumpfile("key1_filter_tb.vcd");  // 保存波形文件
        $dumpvars(0, key1_filter_tb);     // 生成波形
    end

endmodule
