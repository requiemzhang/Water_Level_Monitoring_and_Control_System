//变换时钟1000hz变到1hz

module clk_1hz (
    input wire clk,       // 输入1kHz时钟
    output reg clk_out    // 输出1Hz时钟
);
    reg [10:0] counter;  // 10位计数器，最大计数到 1023
    initial begin
        counter<=11'd0;
		  clk_out<=1'b0;
    end
    always @(posedge clk ) begin
        if (counter == 11'd999) begin // 计数到999时翻转输出信号
            counter <= 11'b0;
            clk_out <= 1'b1;        // 翻转输出，得到1Hz信号
        end
        else begin
            counter <= counter + 1;
				clk_out <= 1'b0; 

        end
    end
endmodule	