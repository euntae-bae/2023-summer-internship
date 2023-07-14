package Tb;

interface Egg_IFC;
    method Action pend;
    method Action msgSend;
endinterface

(* synthesize *)
module mkEgg (Egg_IFC);
    Reg#(Bit#(8)) ansCnt <- mkReg(0);
    Reg#(Bool) pending <- mkReg(False);
  
    rule msgGenerate if (pending);
        //$display("msgGenerate: ansCnt=%d", ansCnt);
        if (ansCnt == 20)
            pending <= False;
        else begin
            $write(".");
            ansCnt <= ansCnt + 1;
        end
    endrule

    method Action pend if (!pending);
        pending <= True;
    endmethod

    method Action msgSend if (!pending && ansCnt >= 20);
        $display("Fimally!");
        $finish(0);
    endmethod
endmodule

(* synthesize *)
module mkTb (Empty);
    Egg_IFC egg <- mkEgg;
    Reg#(Bool) busy <- mkReg(False);

    rule startup (!busy);
        $display("Pre-Cracked egg");
        $display("Saves time!");
        $display("No messy hand");
        $write("I enjoy ");
        egg.pend();
        busy <= True;
    endrule

    rule msgPend (busy);
        egg.msgSend();
    endrule
endmodule

endpackage