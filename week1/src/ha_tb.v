`timescale 1ns / 1ps

module ha_tb;
	reg a, b;
	wire s, c;
	
	//ha uut(.a(a), .b(b), .sum(s), .carry(c));
	ha uut(a, b, s, c);

	initial begin
		a = 0; b = 0;
		#1000 $finish;
	end

	initial begin
		$dumpfile("ha_dump.vcd");
		$dumpvars(0, ha_tb);
	end

	always #50 a = ~a;
	always #100 b = ~b;
endmodule

