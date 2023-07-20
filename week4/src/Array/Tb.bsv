package Tb;

(* synthesize *)
module mkTb (Empty);
    Reg#(Bit#(16)) arr1d[5];
    /* statically elaborate */
    for (Integer i = 0; i < 5; i = i + 1)
        arr1d[i] <- mkReg(0);

    Reg#(Bit#(8)) step <- mkReg(0);

    rule display;
        $display("[%d] arr1d: %d %d %d %d %d", 
            step, arr1d[0], arr1d[1], arr1d[2], arr1d[3], arr1d[4]);
        // $display("arr2d: %d %d %d, %d %d %d",
        //     arr2d[0][0], arr2d[0][1], arr2d[0][2],
        //     arr2d[1][0], arr2d[1][1], arr2d[1][2]);
        if (step > 10)
            $finish;
    endrule

    rule update;
        for (Integer i = 0; i < 5; i = i + 1) begin
            arr1d[i] <= arr1d[i] + fromInteger((i + 1) * 10);
        end
        step <= step + 1;
    endrule
endmodule

endpackage