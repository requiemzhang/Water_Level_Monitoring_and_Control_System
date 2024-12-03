//变换时钟1000hz变到2hz

module clk_2hz (
    input wire clk,       // 输入1kHz时钟
    output reg clk_out    // 输出2Hz时钟
);
    reg [8:0] counter;  // 9位计数器，最大计数到 
    initial begin
        counter=9'd0;
    end
    always @(posedge clk ) begin
        if (counter == 9'd499) begin // 计数到499时翻转输出信号
            counter <= 9'b0;
            clk_out <= ~clk_out;        // 翻转输出，得到2Hz信号
        end
        else begin
            counter <= counter + 1;
        end
    end
endmodule	