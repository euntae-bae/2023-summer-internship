package Counter;

interface Counter_IFC;
    method Bool ovf;
endinterface

(* synthesize *)
module mkCounter#(parameter Integer bw, parameter int rate) (Counter_IFC);
    Reg#(Bit#(24)) cnt <- mkReg(0);

    rule rlInc;
        if (cnt == rate)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    endrule

    method Bool ovf;
        return (cnt == rate);
    endmethod
endmodule

endpackage