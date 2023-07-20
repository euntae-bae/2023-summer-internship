package Tb;

import FIFOF::*;

(* synthesize *)
module mkTb (Empty);
    FIFOF#(Bit#(8)) myFifo <- mkSizedFIFOF(20);
    Reg#(Bit#(8)) cnt <- mkReg(10);
    Reg#(Bool) pushComplete <- mkReg(False);

    //(* mutually_exclusive = "rlPush, rlPop" *)
    rule rlPush (!pushComplete);
        if (cnt == 0) begin
            $display("push complete!");
            pushComplete <= True;
        end
        else begin
            Bit#(8) idx = 10 - cnt;
            Bit#(8) inputValue = (idx + 1) * 10;
            $display("push[%3d]: %d", idx, inputValue);
            myFifo.enq(inputValue);
            cnt <= cnt - 1;
        end
    endrule

    rule rlPop (pushComplete);
        $display("pop[%4d]: %d", cnt, myFifo.first);
        myFifo.deq;
        cnt <= cnt + 1;
    endrule

    rule rlFinish (pushComplete && !myFifo.notEmpty);
        $display("finished at", $time);
        $finish;
    endrule
endmodule

endpackage