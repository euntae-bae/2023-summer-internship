package Tb;

interface M1_IFC;
    method int getX();
    method Action incX();
endinterface

(* synthesize *)
module mkM1 #(parameter int init_val) (M1_IFC);
    Reg#(int) x <- mkReg(init_val);
    method int getX = x;
    method Action incX();
        x <= x + 1;
    endmethod
endmodule

(* synthesize *)
module mkTb (Empty);
    M1_IFC m1i1 <- mkM1(2);
    M1_IFC m1i2 <- mkM1(5);

    rule i1Inc (m1i1.getX <= m1i2.getX);
        m1i1.incX();
    endrule

    rule i2Inc (m1i1.getX > m1i2.getX);
        m1i2.incX;
    endrule

    rule m1Display;
        let i1x = m1i1.getX;
        let i2x = m1i2.getX();
        $display("m1i1.x: %d, m1i2.x: %d", i1x, i2x);
        if((i1x == i2x) && (i1x == 20)) begin
            $display("finished at ", $time);
            $finish;
        end
    endrule
endmodule

endpackage