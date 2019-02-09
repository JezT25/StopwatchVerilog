/* STOPWATCH MAIN CODE */

`timescale 1s/1us 

module stopwatch(power, mclk, clk, resetb, start, tensmin, onesmin, tens, ones);
	input 				power, mclk, clk, resetb, start;
	output reg 	[3:0]	tensmin, onesmin, tens, ones;
	
	reg [3:0] tensmintemp, onesmintemp, tenstemp, onestemp;
	reg [1:0] cstate, nstate;
	reg	[2:0] cdisplay, ndisplay;
	
	parameter reset		= 0;
	parameter running	= 1;
	parameter paused	= 2;
	
	parameter display0	= 0;
	parameter display1 	= 1;
	parameter display2	= 2;
	parameter display3	= 3;
	parameter display4	= 4;
	
	always @ (negedge mclk or power)
		if(power)
			cdisplay <= ndisplay;
		else
			cdisplay <= display0;
	
	always @ (negedge clk or start or resetb or power)
		if(!start && resetb && power)
			cstate <= reset;
		else if(!start && power)
			cstate <= paused;
		else if(start && power)
			cstate <= nstate;
			
	always @ (cdisplay)
		case (cdisplay)
			display0: begin ones <= 4'bz; tens <= 4'bz; onesmin <= 4'bz; tensmin <= 4'bz; ndisplay <= display1; end
			display1: begin ones <= onestemp; tens <= 4'bz; onesmin <= 4'bz; tensmin <= 4'bz; ndisplay <= display2; end
			display2: begin ones <= 4'bz; tens <= tenstemp; onesmin <= 4'bz; tensmin <= 4'bz; ndisplay <= display3; end
			display3: begin ones <= 4'bz; tens <= 4'bz; onesmin <= onesmintemp; tensmin <= 4'bz; ndisplay <= display4; end
			display4: begin ones <= 4'bz; tens <= 4'bz; onesmin <= 4'bz; tensmin <= tensmintemp; ndisplay <= display1; end
		endcase
	
	always @ (start or resetb or power)
		if(start && power)
			nstate <= running;
		else if(!start && power)
			nstate <= paused;
		else if(!start && resetb && power)
			nstate <= reset;
			
	always @ (negedge clk or cstate or power)
		case (cstate) 
			reset:		begin
							onestemp <= 0;
							tenstemp <= 0;
							onesmintemp <= 0;
							tensmintemp <= 0;
						end
			running:	begin
							onestemp++;
							if(onestemp==10) begin onestemp <= 0; tenstemp++; end
							if(tenstemp==6)	 begin tenstemp <= 0; onesmintemp++; end
							if(onesmintemp==10) begin onesmintemp <= 0; tensmintemp++; end
							if(tensmintemp==10) begin tensmintemp <= 0; end
						end
			paused:		begin
							onestemp <= onestemp;
							tenstemp <= tenstemp;
							onesmintemp <= onesmintemp;
							tensmintemp <= tensmintemp;
						end
		endcase
endmodule				