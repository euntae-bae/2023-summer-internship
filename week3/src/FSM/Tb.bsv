package Tb;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(3)) state <- mkReg(0);

    rule rlStartup (state == 0);
        $display("Pre-Cracked egg");
        state <= 1;
    endrule

    rule rlSavesTime (state == 1);
        $display("Saves time!");
        state <= 2;
    endrule

    rule rlNoMessyHand (state == 2);
        $display("No messy hand");
        state <= 3;
    endrule

    rule rlIEnjoy (state == 3);
        $display("I enjoy");
        state <= 4;
    endrule

    rule rlFimally (state == 4);
        $display("Fimally!");
        $finish(0);
    endrule
endmodule

endpackage