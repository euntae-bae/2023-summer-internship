`timescale 1ns / 1ps

// 4비트 BCD값을 공용 애노드 FND 입력으로 변환하는 디코더
// BCD to common-anode seven-segment display decoder (74LS47)
module BCDDecoder(bcd, seg);
    input [3:0] bcd;
    output reg [6:0] seg;
    
    always @(bcd) begin
        case (bcd)
            0: seg = 7'b000_0001;
            1: seg = 7'b100_1111;
            2: seg = 7'b001_0010;
            3: seg = 7'b000_0110;
            4: seg = 7'b100_1100;
            5: seg = 7'b010_0100;
            6: seg = 7'b010_0000;
            7: seg = 7'b000_1111;
            8: seg = 7'b000_0000;
            9: seg = 7'b000_0100;
            default: seg = 7'b111_1111; // 가능한 모든 경우의 수에 대하여 출력을 결정하여 의도치 않은 latch가 생성되지 않도록 주의한다
        endcase        
    end
endmodule
