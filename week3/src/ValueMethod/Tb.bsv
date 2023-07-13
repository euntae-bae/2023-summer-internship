package Tb;

(* synthesize *)
module mkTb (Empty);
    Ifc_type ifc <- mkModuleDeepThought;

    rule theUltimateAnswer;
        $display("Hello World! The answer is: %d", ifc.the_answer(10, 15, 17));
        $finish(0);
    endrule
endmodule: mkTb

interface Ifc_type;
    method int the_answer (int x, int y, int z);
endinterface: Ifc_type

(* synthesize *)
module mkModuleDeepThought (Ifc_type);
    method int the_answer (int x, int y, int z);
        return x + y + z;
    endmethod
endmodule: mkModuleDeepThought

endpackage: Tb