`timescale 1ns / 1ps

// LED Shift v1
module ledShift(clk, ledOut);
    input clk;
    output reg [15:0] ledOut = 16'h0001;
    reg [25:0] cnt = 1;
    
    always @(posedge clk) begin
        // 26비트 카운터 오버플로우 시 LED 상태 업데이트
        if (cnt == 0) begin
            if (ledOut == 16'h8000)
                ledOut <= 16'h0001;
            else
                ledOut <= ledOut << 1;
        end 
        
        cnt <= cnt + 1;
    end
endmodule

