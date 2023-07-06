`timescale 1ns / 1ps
// ledShift v3 with reset
module ledShift(clk, rstn, shDir, shFast, ledOut);
    input clk;
    input rstn;
    input shDir;
    input shFast;
    output reg [15:0] ledOut;
    reg [25:0] cnt;
    reg prevMSB;
    
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            ledOut <= 16'h0001;
            cnt <= 0;
            prevMSB <= 0;
        end
        
        else begin
            // 26비트 카운터 오버플로우 시 LED 상태 업데이트
            // 오버플로우 검출 코드 업데이트: 카운터의 MSB가 이전에 1이었다가 0이 되면 오버플로우가 발생한 것이다.
            if ((prevMSB == 1) && (cnt[25] == 0)) begin
                if (shDir) begin
                    if (ledOut == 16'h0001)
                        ledOut <= 16'h8000;
                    else
                        ledOut <= ledOut >> 1;
                end
                else begin
                    if (ledOut == 16'h8000)
                        ledOut <= 16'h0001;
                    else
                        ledOut <= ledOut << 1;
                end
            end 
            
            prevMSB <= cnt[25];
            if (shFast)
                cnt <= cnt + 5;
            else
                cnt <= cnt + 1;
                
        end
    end
endmodule

