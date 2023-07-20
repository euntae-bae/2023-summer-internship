package Tb;
import StmtFSM::*;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bool) complete <- mkReg(False);

    Stmt egg = seq
        $display("Pre-Cracked egg");
        $display("Saves time!");
        // an action with several actions still only take one cycle
        action
            $display("No messy hand");
            $display("I enjoy");
        endaction
        $display("Fimally!");
        complete <= True;
    endseq;

    FSM eggFSM <- mkFSM(egg);

    rule startit;
        eggFSM.start();
    endrule

    rule alwaysrun;
        $display("\t\tand a rule fires at", $time);
        if (complete)
            $finish(0);
    endrule
endmodule

endpackage