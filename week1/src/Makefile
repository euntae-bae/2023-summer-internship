all: ha fa fa_dataflow counter8

run: ha fa counter8
	vvp ha
	vvp fa
	vvp fa_dataflow
	vvp counter8

ha: ha.v ha_tb.v
	iverilog -o ha ha.v ha_tb.v

fa: fa.v fa_tb.v
	iverilog -o fa fa.v fa_tb.v

fa_dataflow: fa_dataflow.v fa_tb.v
	iverilog -o fa_dataflow fa_dataflow.v fa_tb.v

counter8: counter8.v counter8_tb.v
	iverilog -o counter8 counter8.v counter8_tb.v

clean:
	rm ha
	rm fa
	rm fa_dataflow
	rm counter8
	rm *.vcd

