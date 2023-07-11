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

// Top module
module FNDCounter(clk, rstn, seg, an);
    input clk;
    input rstn;
    output [6:0] seg;   // LED
    output reg [7:0] an;// FND selection (decoded)
    reg [31:0] fndcnt;  // Decimal up-counter
    reg [2:0]  fndsel;  // FND selection
    reg [3:0] bcd;

    wire fndovf;
    wire refreshovf;

    Counter24                  fctr(clk, rstn, fndovf);    // 10ms
    Counter24 #(.RATE(125000)) rctr(clk, rstn, refreshovf); // 10/8ms
    BCDDecoder dec(bcd, seg);

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

    // FND Decimal counter update
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            fndcnt <= 0;
        end
        else begin
            if (fndovf)
                fndcnt <= fndcnt + 1;
        end
    end

    // FND select update
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            fndsel <= 0;
        end
        else begin
            if (refreshovf)
                fndsel <= fndsel + 1;
        end
    end
endmodule