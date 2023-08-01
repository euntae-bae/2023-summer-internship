package Tb;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(16)) x <- mkReg(0);
    Reg#(Bit#(16)) y <- mkReg(0);

    //(* execution_order = "rl1, rl2" *)
    //(* descending_urgency = "rl2, rl1" *)
    (* execution_order = "rl1, rl2" *)
    rule rl1;
        $display(x._read()); // $display(x);
    endrule

    rule rl2;
        y <= y + 1;
        x._write(y._read()); // x <= y;
    endrule
endmodule

endpackage