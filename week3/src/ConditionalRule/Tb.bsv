package Tb;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(8)) cnt <- mkReg(0);
    
    rule cntUp if (cnt <= 10);
        $display("cntUp: cnt == %d", cnt);
        cnt <= cnt + 1;
    endrule

    rule cntEnd if (cnt >= 10);
        $display("cntEnd: cnt == %d", cnt);
        $finish(0);
    endrule
endmodule

endpackage