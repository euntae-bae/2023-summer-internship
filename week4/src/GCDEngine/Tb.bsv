package Tb;
import FIFOF::*;

typedef struct {
    Bit#(8) id;
    Bit#(32) x;
    Bit#(32) y;
} Req deriving (Bits, Eq);

typedef struct {
    Bit#(8) id;
    Bit#(32) result;
} Resp deriving (Bits, Eq);

interface GCD_IFC;
    method Action put(Req req);
    method ActionValue#(Resp) get();
    method Bool isRespQEmpty();
endinterface

(* synthesize *)
module mkGCD (GCD_IFC);
    FIFOF#(Req) reqQ <- mkSizedFIFOF(20);
    FIFOF#(Resp) respQ <- mkSizedFIFOF(20);

    Reg#(Bit#(8)) reqId <- mkReg(0);
    Reg#(Bit#(32)) x <- mkReg(0);
    Reg#(Bit#(32)) y <- mkReg(0);
    Reg#(Bool) busy <- mkReg(False);

    (* descending_urgency = "fetch, put" *)
    (* mutually_exclusive = "fetch, step1, step2" *)
    rule fetch (reqQ.notEmpty() && !busy);
        Req req = reqQ.first();
        reqQ.deq;
        reqId <= req.id;
        x <= req.x;
        y <= req.y;
        busy <= True;
        $display("\tfetch: ID=%d, x=%d, y=%d at %t", req.id, req.x, req.y, $time);
    endrule

    rule step1 ((x > y) && (y != 0));
        // swap
        x <= y;
        y <= x;
        //$display("step1: %d, %d", x ,y);
    endrule

    rule step2 ((x <= y) && (y != 0));
        y <= y - x;             // subtract
        if (y - x == 0) begin   // stop
            Resp resp;
            resp.id = reqId;
            resp.result = x;
            respQ.enq(resp);
            busy <= False;
            //$display("\tcomplete: id=%d, result=%d, at %t", resp.id, resp.result, $time);
        end
        //$display("step2: %d, %d", x ,y);
    endrule

    method Action put(Req req) if (reqQ.notFull());
        //$display("put: ID=%d, x=%d, y=%d at %t", req.id, req.x, req.y, $time);
        reqQ.enq(req);
    endmethod

    method ActionValue#(Resp) get() if (respQ.notEmpty());
        respQ.deq;
        return respQ.first;
    endmethod

    method Bool isRespQEmpty();
        return !respQ.notEmpty();
    endmethod
endmodule

(* synthesize *)
module mkTb (Empty);
    GCD_IFC gcdEngine <- mkGCD;
    Reg#(Bit#(8)) curId <- mkReg(0);
    Reg#(Bit#(8)) completeCnt <- mkReg(0);

    rule rlProduce;
        Req req;
        req.id = curId;
        req.x = zeroExtend(curId) * 5 + 72;
        req.y = zeroExtend(curId) * 4 + 21;
        gcdEngine.put(req);
        curId <= curId + 1;
        $display("put: ID=%d, x=%d, y=%d at %t", req.id, req.x, req.y, $time);
    endrule

    rule rlConsume;
        let resp <- gcdEngine.get();
        $display("\tget: ID=%d, result=%d at %t", resp.id, resp.result, $time);
        completeCnt <= completeCnt + 1;
    endrule

    rule rlFinish (completeCnt > 10 && gcdEngine.isRespQEmpty);
        $display("finished at ", $time);
        $finish;
    endrule
endmodule

endpackage