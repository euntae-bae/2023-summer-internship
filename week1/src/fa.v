`include "ha.v"

// 반가산기와 다르게 a, b, cin 세 개 입력을 받는다.
// 반가산기는 a와 b만을 입력으로 받는다.
// 전가산기는 앞 덧셈의 carry를 추가로 입력받는다.
module fa(a, b, cin, s, cout);
    input a, b, cin;
    output s, cout;

    // 내부 신호선 s1, c1, c2 선언
    wire s1, c1;    // h1의 출력
    wire c2;        // h2의 출력

    ha h1(a, b, s1, c1);                        // 입력 a와 b의 덧셈
    ha h2(.a(s1), .b(cin), .sum(s), .carry(c2)); // a+b와 cin(input carry)의 덧셈, s는 최종 출력될 sum
    assign cout = c1 | c2;                      // cout은 최종 출력될 carry
endmodule