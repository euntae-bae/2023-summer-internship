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
    //parameter rate = 10000000;
    parameter rate = 100000;

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
    output reg [7:0] an;
    reg [3:0] bcdArr [7:0]; // 8개 FND의 BCD값
    reg bcdCarry;
    wire [3:0] bcd;
    reg [2:0] fndsel;       // 현재 출력할 FND 선택

    integer i;

    wire fndclk;
    wire refreshclk;

    Counter24 fctr(clk, rstn, fndclk);
    RefreshCounter rctr(clk, rstn, refreshclk);
    BCDDecoder dec(bcd, seg);

    assign bcd = bcdArr[fndsel];

    always @(*) begin
        case (fndsel) 
            3'b000: an = 8'b00000001;
            3'b001: an = 8'b00000010;
            3'b010: an = 8'b00000100;
            3'b011: an = 8'b00001000;
            3'b100: an = 8'b00010000;
            3'b101: an = 8'b00100000;
            3'b110: an = 8'b01000000;
            3'b111: an = 8'b10000000;
            default: an = 8'b00000001;
        endcase
    end

    // BCD counter value update
    always @(posedge fndclk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < 8; i = i + 1) begin
                bcdArr[i] = 4'b0000;
            end
        end
        else begin
            if (bcdArr[0] == 4'b1001) begin
                bcdArr[0] = 4'b0000;
                bcdCarry = 1;
                for (i = 1; i < 8; i = i + 1) begin
                    if (bcdCarry == 1) begin
                        if (bcdArr[i] == 4'b1001) begin
                            bcdArr[i] = 4'b0000;
                            bcdCarry = 1;
                        end
                        else begin
                            bcdArr[i] = bcdArr[i] + 1;
                            bcdCarry = 0;
                        end
                    end
                end
            end
            else begin
                bcdArr[0] = bcdArr[0] + 1;
                bcdCarry = 0;
            end
        end
    end

    // FND select update
    always @(posedge refreshclk or negedge rstn) begin
        if (!rstn) begin
            fndsel <= 0;
        end
        else begin
            fndsel <= fndsel + 1;
        end
    end
endmodule