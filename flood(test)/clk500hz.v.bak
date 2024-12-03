//变换时钟1000hz变到500hz

module clk500hz (
    input wire clk,       // 输入1000Hz时钟
    output reg clk_out    // 输出500Hz时钟
);
    reg [1:0] counter;  // 2位计数器，最大计数到 1
    initial begin
        counter=2'd0;
    end
    always @(posedge clk ) begin
        if (counter == 2'd1) begin // 计数到1时翻转输出信号
            counter <= 2'b0;
            clk_out <= ~clk_out;        // 翻转输出，得到500Hz信号
        end
        else begin
            counter <= counter + 1;
        end
    end
endmodule	