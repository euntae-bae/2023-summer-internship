package Tb;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(16)) x <- mkReg(0);
    Reg#(Bit#(16)) y <- mkReg(0);

    (* descending_urgency = "rl2, rl1" *)
    (* execution_order = "rl2, rl1" *)
    rule rl1;
        $display("rl1: x=%d", x._read()); // $display(x);
    endrule

    rule rl2;
        $display("rl2");
        y <= y + 1;
        x._write(y._read()); // x <= y;
    endrule
endmodule

endpackage