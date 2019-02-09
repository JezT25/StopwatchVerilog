/* STOPWATCH TESTBENCH */

module tb_stopwatch;
	reg 			Power, milliClock, Clock, ResetB, Start;
	wire	[3:0]	TENSmin, ONESmin, Tens, Ones;
	
	stopwatch UUT(.power(Power), .mclk(milliClock), .clk(Clock), .resetb(ResetB), .start(Start), .tensmin(TENSmin), .onesmin(ONESmin), .tens(Tens), .ones(Ones));
	
	initial begin
		$dumpfile("stopwatch.vpd");
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
		#70;
		
		ResetB = 1;
		#3;
		
		ResetB = 0;
		#3;
		
		Start = 0;
		#5;
		
		ResetB = 1;
		#1;
		ResetB = 0;
		#5;
		
		Start = 1;
		#10;
		
		Start = 0;
		Power = 0;
		#5;
		
		Power = 1;
		ResetB = 1;
		#5;
		
		Start = 1;
		ResetB = 0;
		#100;
		
		$finish;
	end 
endmodule 