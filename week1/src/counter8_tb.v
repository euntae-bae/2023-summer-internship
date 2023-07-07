`timescale 1ns / 10ps

module counter8_tb;
    reg clk, rst;
    wire [7:0] cnt;

    counter8 uut(clk, rst, cnt);

    initial begin
        $dumpfile("counter8_dump.vcd");
        $dumpvars(0, counter8_tb);
    end

    initial begin
        clk = 0;
        rst = 0;
        #5 rst = 1;
        #20 rst = 0;
        #2 rst = 1;
        #50 $finish;
    end

    always #1 clk = ~clk;
endmodule