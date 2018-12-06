module VGA(red, green, blue, hsync, vsync, led, sw, reset, CLK);

	input [0:3] sw;
	input reset, CLK;
	
	output reg [0:3] red;
	output reg [0:3] green;
	output reg [0:3] blue;
	output reg hsync, vsync, led;
	
	reg [9:0] hsyncCounter;
	reg [9:0] vsyncCounter;
	
	always @ (posedge CLK) begin
		if(hsyncCounter == 10'd800) 
			hsyncCounter = 10'd0;
		else
			hsyncCounter = hsyncCounter + 1;
	end
	
	
	
	always @ (counter) begin
		if(hysncCounter < 49) {
			hsync = 0;
		}
	end
	
endmodule