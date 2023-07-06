`timescale 1ns / 1ps

// CLK100MHZ, T=10ns
// 1000ns=10us
module RefreshCounter(sysclk, rstn, ovf);
    input sysclk;
    input rstn;
    output reg ovf;

    reg [15:0] cnt;
    parameter refreshRate = 1000;

    always @(posedge sysclk or negedge rstn) begin
        if (!rstn) begin
            cnt <= 0;
            ovf <= 0;
        end
        else begin
            if (cnt == refreshRate)
                ovf <= 1;
            else
                ovf <= 0;
            cnt <= cnt + 1;
        end
    end
endmodule

//100ms=100*1000us=100*1000*1000ns=10^8ns=10^7*10ns => 24비트로 표현 가능
module Counter24(sysclk, rstn, ovf);
    input sysclk;
    input rstn;
    output reg ovf;

    reg [23:0] cnt;
    parameter rate = 10000000;

    always @(posedge sysclk or negedge rstn) begin
        if (!rstn) begin
            cnt <= 0;
            ovf <= 0;
        end
        else begin
            if (cnt == rate)
                ovf <= 1;
            else
                ovf <= 0;
            cnt <= cnt + 1;
        end
    end
endmodule

// Top module
module FNDCounter(clk, rstn, seg, an);
    input clk;
    input rstn;
    output [6:0] seg;
    output [7:0] an;
    reg [3:0] fndArr [2:0]; // 8개 FND의 BCD값

    integer i;

    BCDDecoder dec();

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cnt <= 0;
            cntRefresh <= 0;
        end
        else begin

        end
    end

    always @(posedge clk) begin
        if (!rstn) begin

        end
    end

endmodule