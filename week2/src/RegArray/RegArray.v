`timescale 10ns / 1ps

module RegArray;
    reg clk;
    reg rstn;
    reg [3:0] bcdArr [0:7];
    integer i;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, RegArray);
    end

    initial begin
        clk = 0;
        rstn = 0;
        for (i = 0; i < 7; i = i + 1)
            bcdArr[i] = 4'b0000;
        #5  rstn = 1;
        #20 rstn = 0;
        #2  rstn = 1;
        #50 $finish;
    end

    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            for (i = 0; i < 7; i = i + 1)
                bcdArr[i] = 4'b0000;
        end
        else begin
            for (i = 0; i < 7; i = i + 1)
                bcdArr[i] = bcdArr[i] + 1;
        end
    end

    always #1 clk = ~clk;

endmodule