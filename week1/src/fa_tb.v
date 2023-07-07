`timescale 1ns / 10ps

module fa_tb;
    reg a, b, cin;
    wire sum, carry;
    //fa uut(a, b, cin, sum, carry);
    fa uut(.a(a), .b(b), .cin(cin), .s(sum), .cout(carry));

    initial begin
        $dumpfile("fa_dump.vcd");
        $dumpvars(0, fa_tb);
    end

    initial begin
        a <= 0; b <= 0; cin <= 0;
        #1000 $finish;
    end

    always #50 a = ~a;
    always #100 b = ~b;
    always #200 cin = ~cin;
endmodule