`timescale 1ns / 1ps

module FNDCounter_tb;
    reg clk, rstn;
    wire [6:0] seg;
    wire [7:0] an;
    //reg [7:0] cnt;

    FNDCounter uut(clk, rstn, seg, an);

    initial begin
        $dumpfile("FNDCounter_dump.vcd");
        $dumpvars(0, FNDCounter_tb);
    end

    initial begin
        clk = 0;
        rstn = 0;
        //cnt = 0;
        #5 rstn = 1;
    end

    always #1 clk = ~clk;
    always @(posedge clk) begin
        if (an == 0 && seg == 7'b000_0100) begin
            $finish;
        end
    end
endmodule