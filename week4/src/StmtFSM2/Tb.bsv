package Tb;
import StmtFSM::*;

(* synthesize *)
module mkTb (Empty);
    Stmt egg = seq
        $display("Pre-Cracked egg");
        action
            $display("Saves time!");
            $display("No messy hand");
            $display("I enjoy");
        endaction
        $display("Fimally!");
    endseq;

    mkAutoFSM(egg);

    rule alwaysrun;
        $display("\t\tand a rule fires at", $time);
    endrule
endmodule

endpackage