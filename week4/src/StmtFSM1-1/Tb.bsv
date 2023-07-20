package Tb;
import StmtFSM::*;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bool) complete <- mkReg(False);

    Stmt egg = seq
        $display("Pre-Cracked egg");
        $display("Saves time!");
        $display("No messy hand");
        $display("I enjoy");
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