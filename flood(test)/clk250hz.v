//变换时钟1000hz变到250hz

module clk250hz (
    input wire clk,       // 输入kHz时钟
    output reg clk_out    // 输出250Hz时钟
);
    reg [2:0] counter;  // 3位计数器，最大计数到 7
    initial begin
        counter=3'd0;
    end
    always @(posedge clk ) begin
        if (counter == 3'd3) begin // 计数到3时翻转输出信号
            counter <= 3'b0;
            clk_out <= ~clk_out;        // 翻转输出，得到250Hz信号
        end
        else begin
            counter <= counter + 1;
        end
    end
endmodule	