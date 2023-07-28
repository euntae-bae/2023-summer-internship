package Tb;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(16)) x <- mkReg(0);
    Reg#(Bit#(16)) y <- mkReg(0);

    //(* descending_urgency = "rlIncAndSwapY, rlIncAndSwapX" *)
    rule rlIncAndSwapX;
        // y.read
        // x.write
        x <= y + 1;
    endrule

    rule rlIncAndSwapY;
        // x.read
        // y.write
        y <= x + 1;
    endrule

    rule rlDisplay;
        $display("x: %d, y: %d", x, y);
    endrule

    rule rlFinish (x > 10);
        $display("finishec at ", $time);
        $finish;
    endrule
endmodule

endpackage