package Tb;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(16)) x <- mkReg(0);
    Reg#(Bit#(16)) y <- mkReg(0);

    // runs atomically
    rule rlIncAndSwap;
        x <= y + 1;
        y <= x + 1;
    endrule

    rule rlDisplay;
        $display("x: %d, y: %d", x, y);
    endrule

    rule rlFinish (x > 110);
        $display("finished at ", $time);
        $finish;
    endrule
endmodule

endpackage