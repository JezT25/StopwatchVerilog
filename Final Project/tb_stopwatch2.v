/* STOPWATCH TESTBENCH 2*/

module tb_stopwatch;
	reg 			Power, milliClock, Clock, ResetB, Start;
	wire	[3:0]	TENSmin, ONESmin, Tens, Ones;
	
	stopwatch UUT(.power(Power), .mclk(milliClock), .clk(Clock), .resetb(ResetB), .start(Start), .tensmin(TENSmin), .onesmin(ONESmin), .tens(Tens), .ones(Ones));
	
	initial begin
		$dumpfile("stopwatch2.vpd");
		$dumpvars;
		
		Clock = 0;
		milliClock = 0;
	end 
	
	always
		#0.003125 milliClock = ~milliClock;
	
	always
		#0.5 Clock = ~Clock;
	
	initial begin 
		Power = 0;
		#1;
		Power = 1;
		ResetB = 1;
		Start = 0;
		#1;
		
		ResetB = 0;
		Start = 1;
		#6600
		
		$finish;
	end 
endmodule 