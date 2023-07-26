package Tb;

interface Counter_IFC;
    method Bit#(32) count();
endinterface

(* synthesize *)
module mkCounter (Counter_IFC);
    Reg#(Bit#(32)) cnt <- mkReg(0);

    rule rlCnt;
        cnt <= cnt + 1;
    endrule

    method Bit#(32) count() if (cnt % 2 == 0);
        return cnt;
    endmethod
endmodule

(* synthesize *)
module mkTb (Empty);
    Counter_IFC ctr <- mkCounter;
    Reg#(Bit#(32)) accum <- mkReg(0);

    rule rlDisplayEven;
        let cnt = ctr.count;
        $display("[%t] rlDisplayEven, accum=%d", $time, accum);
        $display("--> cnt=%d", cnt);
        accum <= accum + cnt;
    endrule

    rule rlEnd (ctr.count > 100);
        $display("[%t] rlEnd", $time);
        $finish;
    endrule
endmodule

endpackage