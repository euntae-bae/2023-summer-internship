`timescale 1ns / 1ps

// CLK100MHZ, T=10ns
// 10/8ms =  125000ticks
// 10ms   = 1000000ticks
//100ms=100*1000us=100*1000*1000ns=10^8ns=10^7*10ns => 24비트로 표현 가능
module Counter24 #(parameter RATE = 1000000)(sysclk, rstn, ovf);
    input sysclk;
    input rstn;
    output reg ovf;
    reg [23:0] cnt;

    always @(posedge sysclk or negedge rstn) begin
        if (!rstn) begin
            cnt <= 0;
            ovf <= 0;
        end
        else begin
            if (cnt == RATE) begin
                ovf <= 1;
                cnt <= 0;
            end
            else begin
                ovf <= 0;
                cnt <= cnt + 1;
            end
        end
    end
endmodule
