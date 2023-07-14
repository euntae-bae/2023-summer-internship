package Tb;
    interface GCD_IFC;
        method Action start(Bit#(32) a, Bit#(32) b);
        method Bit#(32) result();
    endinterface

    /* Euclidian Algorithm: */
    /*
    def gcd(a, b):
        if a == 0:
            return b # stop 
        elif a >= b:
            return gcd(a - b, b) # subtract
        else:
            return gcd(b, a)
    */

    (* synthesize *)
    module mkGCD (GCD_IFC);
        Reg#(Bit#(32)) x <- mkReg(0);
        Reg#(Bit#(32)) y <- mkReg(0);
        Reg#(Bit#(32)) res <- mkReg(0);

        rule step1 ((x > y) && (y != 0));
            // swap
            x <= y;
            y <= x;
            $display("step1: %d, %d", x ,y);
        endrule

        rule step2 ((x <= y) && (y != 0));
            y <= y - x;             // subtract
            if (y - x == 0) begin   // stop
                res <= x;
            end
            $display("step2: %d, %d", x ,y);
        endrule

        method Action start(Bit#(32) a, Bit#(32) b) if (y == 0);
            x <= a;
            y <= b;
        endmethod

        method Bit#(32) result();
            return res;
        endmethod
    endmodule

    (* synthesize *)
    module mkTb (Empty);
        GCD_IFC gcd <- mkGCD;
        Reg#(Bit#(32)) gcdResult <- mkReg(0);
        Reg#(Bit#(3)) state <- mkReg(0);

        rule rlStart (state == 0);
            gcd.start(36, 21);
            state <= 1;
        endrule

        rule rlPend (state == 1);
            $display("wait...");
            gcdResult <= gcd.result();
            if (gcdResult != 0) begin
                state <= 2;
            end
        endrule

        rule rlResult (state == 2);
            $display("GCD Result: %d", gcdResult);
            $finish(0);
        endrule

    endmodule
endpackage