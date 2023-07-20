package Tb;

import Vector::*;

(* synthesize *)
module mkTb (Empty);
    // Vector#(number of items, type of items)
    Reg#(Vector#(5, Bit#(8))) vecreg <- mkReg(replicate(0));    // register of vector
    Vector#(5, Reg#(Bit#(8))) regvec <- replicateM(mkReg(0));   // vector of register
    Reg#(Bit#(8)) step <- mkReg(0);

    rule rlDisplay;
        $display("vecreg: %10x", vecreg);
        $display("regvec: %x%x%x%x%x\n",
            regvec[0], regvec[1], regvec[2], regvec[3], regvec[4]
        );
        if (step > 10)
            $finish;
    endrule

    rule rlUpdate;
        let vec = vecreg;
        vec[0] = vec[0] + 8'h10;
        vec[3] = vec[3] + 8'h01;
        vec[4] = vec[4] + 8'h05;
        vecreg <= vec;

        regvec[0] <= regvec[0] + 8'h02;
        regvec[1] <= regvec[1] + 8'h03;
        regvec[2] <= regvec[2] + 8'h04;

        step <= step + 1;
    endrule
endmodule

endpackage