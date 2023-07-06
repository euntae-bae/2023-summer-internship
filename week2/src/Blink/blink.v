`timescale 1ns / 1ps

module blink(
    input clk,
    output ledOut
    );
    reg [24:0] count = 0;
    assign ledOut = count[24];
    always @(posedge clk) begin
        count <= count + 1;
    end
endmodule
