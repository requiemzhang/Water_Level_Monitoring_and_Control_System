//变换时钟1khz变到100hz

module clk100hz (
    input wire clk,       
    output reg clk_out    
);
    reg [3:0] counter;  // 4位计数器，最大计数到 9 
    initial begin
        counter=4'd0;
    end
    always @(posedge clk ) begin
        if (counter == 4'd9) begin // 计数到9时翻转输出信号
            counter <= 4'b0;
            clk_out <= ~clk_out;        // 翻转输出，得到100Hz信号
        end
        else begin
            counter <= counter + 1;
        end
    end
endmodule	