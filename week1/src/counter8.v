module counter8(clk, rst, cnt);
    input clk, rst;
    output reg [7:0] cnt;

    always @(posedge clk) begin
        // rst: low active
        // 동기 리셋
        if (!rst)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
endmodule