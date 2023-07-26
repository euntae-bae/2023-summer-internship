package Tb;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(16)) x <- mkReg(0);
    Reg#(Bit#(16)) y <- mkReg(0);

    (* descending_urgency = "r2, r1" *)
    rule r1;
        // y.read
        // x.write
        x <= y + 1;
    endrule

    rule r2;
        // x.read
        // y.write
        y <= x + 2;
    endrule

    rule rlDisplay;
        $display("x: %d, y: %d", x, y);
    endrule
endmodule

endpackage