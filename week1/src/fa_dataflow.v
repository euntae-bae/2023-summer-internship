module fa(a, b, cin, s, cout);
    input a, b, cin;
    output s, cout;
    wire s1, c1;
    wire c2;

    assign s1 = a ^ b;
    assign c1 = a & b;
    assign s = s1 ^ cin;
    assign c2 = s1 & cin;
    assign cout = c1 | c2;
endmodule