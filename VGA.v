module VGA(red, green, blue, hsync, vsync, led, sw, reset, CLK);

	input [0:3] sw;
	input reset, CLK;
	
	output reg [0:3] red;
	output reg [0:3] green;
	output reg [0:3] blue;
	output reg hsync, vsync, led;
	
	reg [9:0] hsyncCounter, hNext;
	reg [9:0] vsyncCounter, vNext;
	
	// Next state logic
	always @ (*) begin
		if(hsyncCounter == 10'd800) begin
			hNext = 10'd0;
			if(vsyncCounter == 10'd525) begin
				vNext = 10'd0;
			end
			else begin
				vNext = vsyncCounter + 1;
			end
		end
		else begin
			hNext = hsyncCounter + 1;
			vNext = vsyncCounter;
		end
	end
	
	
	// Clock
	always @ (posedge CLK) begin
	   hsyncCounter = hNext;
		vsyncCounter = vNext;
	end
	
	// Output logic
	always @ (*) begin
		if(hsyncCounter <= 48) begin
			// Back porch
			hsync = 1;
			red = 4'd0;
			green = 4'd0;
			blue = 4'd0;
		end
		else if(hsyncCounter <= 688) begin
			// Active data
			hsync = 1;
			if(hsyncCounter <= 368) begin
				red = 4'd1;
				green = 4'd0;
				blue = 4'd15;
			end
			else begin
				red = 4'd0;
				green = 4'd15;
				blue = 4'd15;
			end
		end
		else if(hsyncCounter <= 704) begin
			// Front porch
			hsync = 1;
			red = 4'd0;
			green = 4'd0;
			blue = 4'd0;
		end
		else if(hsyncCounter <= 800) begin
			// Sync pulse
			hsync = 0;
			red = 4'd0;
			green = 4'd0;
			blue = 4'd0;
		end
		
		
		
		if(vsyncCounter <= 33) begin
			// Back porch
			vsync = 1;
			red = 4'd0;
			green = 4'd0;
			blue = 4'd0;
		end
		else if(vsyncCounter <= 513) begin
			// Active data
			vsync = 1;
		end
		else if(vsyncCounter <= 523) begin
			// Front porch
			vsync = 1;
			red = 4'd0;
			green = 4'd0;
			blue = 4'd0;
		end
		else if(vsyncCounter <= 525) begin
			// Sync pulse
			vsync = 0;
			red = 4'd0;
			green = 4'd0;
			blue = 4'd0;
		end

	end
	
	
endmodule