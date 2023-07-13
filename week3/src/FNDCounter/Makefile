FNDCounter: FNDCounter_tb.v FNDCounter.v BCDDecoder.v
	iverilog -o FNDCounter FNDCounter_tb.v FNDCounter.v BCDDecoder.v

run: FNDCounter
	vvp ./FNDCounter

clean:
	rm FNDCounter
	rm *.vcd
	