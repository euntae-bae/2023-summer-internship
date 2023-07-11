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
            if (cnt == refreshRate) begin
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

module Counter24(sysclk, rstn, clksel, ovf);
    input sysclk;
    input rstn;
    input clksel;
    output reg ovf;

    reg [23:0] cnt;
    //parameter rate = 10000000;
    parameter rate = 1000000;

    always @(posedge sysclk or negedge rstn) begin
        if (!rstn) begin
            cnt <= 0;
            ovf <= 0;
        end
        else begin
            if (clksel) begin
                if (cnt == (rate / 2)) begin
                    ovf <= 1;
                    cnt <= 0;
                end
                else begin
                    ovf <= 0;
                    cnt <= cnt + 1;
                end
            end
            else begin
                if (cnt == rate) begin
                    ovf <= 1;
                    cnt <= 0;
                end
                else begin
                    ovf <= 0;
                    cnt <= cnt + 1;
                end
            end
        end
    end
endmodule

// Top module
module FNDCounter(clk, rstn, clksel, seg, an);
    input clk;
    input rstn;
    input clksel;
    output [6:0] seg;
    output reg [7:0] an;
    reg [31:0] fndcnt;
    reg [2:0]  fndsel;       // 현재 출력할 FND 선택
    reg [3:0] bcd;

    wire fndclk;
    wire refreshclk;

    Counter24 fctr(clk, rstn, clksel, fndclk);
    RefreshCounter rctr(clk, rstn, refreshclk);
    BCDDecoder dec(bcd, seg);

    //assign bcd = bcdArr[fndsel];

    always @(*) begin
        case (fndsel) 
            3'b000: begin
                an = 8'b1111_1110;
                bcd = fndcnt % 10;
            end
            3'b001: begin
                an = 8'b1111_1101;
                bcd = (fndcnt / 10) % 10;
            end
            3'b010: begin
                an = 8'b1111_1011;
                bcd = (fndcnt / 100) % 10;
            end
            3'b011: begin
                an = 8'b1111_0111;
                bcd = (fndcnt / 1000) % 10;
            end
            3'b100: begin
                an = 8'b1110_1111;
                bcd = (fndcnt / 10000) % 10;
            end
            3'b101: begin
                an = 8'b1101_1111;
                bcd = (fndcnt / 100000) % 10;
            end
            3'b110: begin
                an = 8'b1011_1111;
                bcd = (fndcnt / 1000000) % 10;
            end
            3'b111: begin
                an = 8'b0111_1111;
                bcd = (fndcnt / 10000000) % 10;
            end
            default: begin
                an = 8'b1111_1110;
                bcd = fndcnt % 10;
            end
        endcase
    end

    // FND counter update
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            fndcnt <= 0;
        end
        else begin
            if (fndclk)
                fndcnt <= fndcnt + 1;
        end
    end

    // FND select update
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            fndsel <= 0;
        end
        else begin
            if (refreshclk)
                fndsel <= fndsel + 1;
        end
    end
endmodule
