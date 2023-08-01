package Tb;

function Action regUpdate(Reg#(t) r) provisos (Bits#(t, sizea), Arith#(t));
    action
        r <= r + 1;
    endaction
endfunction

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(16)) x <- mkReg(0);
    Reg#(Bit#(32)) y <- mkReg(0);

    function Action displayRegs();
        action
            $display("x=%d, y=%d", x, y);
        endaction
    endfunction

    (* execution_order = "rlEnd, rlUpdateAndDisplay" *)
    rule rlUpdateAndDisplay;
        regUpdate(x);
        regUpdate(y);
        displayRegs();
    endrule

    rule rlEnd (x > 10);
        $display("rlEnd at", $time);
        $finish;
    endrule
endmodule

endpackage