module running_LED(mode, mode_hz, auto, clk, reset, out, led7, led6, led5, led4, led3, led2, led1, led0, out_auto);
   input [3:0] mode;
	input [2:0] mode_hz;
	input clk, reset, auto;
	output reg [25:0] out;
	output [6:0] led7, led6, led5, led4, led3, led2, led1, led0;
	output out_auto;
	wire hz_led;
	wire hz_out;
	reg [3:0] mode_in;
	reg [5:0] index=6'd0, i=6'd0;
	reg [3:0] auto_next=4'd0;
	reg reverse=1'b0;
	
	reg [2:0] countled=3'd0;
	reg [3:0] onled3210;
	wire [9:0] controlled54, controlled76;
	
	
	clock_divider c_d1(clk, mode_hz, hz_out);
	
	always @(posedge hz_out) begin
	   if(mode!=mode_in && auto==1'b0) begin
		   index<=6'd0;
		   i=6'd0;
		   reverse<=1'b0;
		   out[25:0]<=26'd0;
		end
		if(auto_next!=mode_in && auto==1'b1) begin
		   index<=6'd0;
		   i=6'd0;
		   reverse<=1'b0;
		   out[25:0]<=26'd0;
		end
		if(auto==1'b0) begin
		   mode_in<=mode;
		end
		else  begin
		   mode_in<=auto_next;
		end
	   if(reset) begin 
		   index<=6'd0;
			reverse<=1'b0;
			out[25:0]<=26'd0;
			auto_next<=4'd0;
		end
		else begin
		   case(mode_in)
			   4'd0: begin
					for(i=6'd1; i<=6'd26; i=i+6'd1) begin
					   if (i==index || i==index-6'd1 || i==index-6'd2) out[i-6'd1]<=1'b1;
						else out[i-6'd1]<=1'b0;
					end
					if(index<=6'd29 && reverse==1'b0) begin
					   index<=index+6'd1;
						if(index==6'd29) begin 
						   reverse<=1'b1;
							index<=index-6'd1;
						end
					end
					if(index>=6'd0 && reverse==1'b1) begin 
					   index<=index-6'd1;
						if(index==6'd0) begin
						   reverse<=1'b0;
							index<=index+6'd1;
							auto_next<=4'd1;
						end
					end
				end
				4'd1: begin
				   if(index<=6'd25) begin
					   if(reverse==1'b0) begin
					      out[index]<=1'b1;
						end
						else begin
						   out[index]<=1'b0;
						end
					end
					if(index>6'd25) begin
					   if(reverse==1'b0) begin
				         out[index-6'd26]<=1'b0;
						end
						else begin
						   out[index-6'd26]<=1'b1;
						end
					end
				   if(index<=6'd52 && reverse==1'b0) begin
					   index<=index+6'd1;
				      if(index==6'd52) begin
						   reverse<=1'b1;
							index<=index-6'd1;
						end
					end
					if(index>=6'd0 && reverse==1'b1) begin
					   index<=index-6'd1;
						if(index<=6'd0) begin
						   reverse<=1'b0;
							index<=6'd0;
							auto_next<=4'd2;
						end
					end
				end
				4'd2: begin
					if(index==6'd0) out<=26'd0;
					if(out[2:0]==3'd0 || out[3:1]==3'd0 || out[4:2]==3'd0) out<=(out<<1)+26'd1;
					else out<=out<<1;
					if(index<=52) index<=index+6'd1;
					else begin
					   index<=6'd27;
						auto_next<=4'd3;
					end
			   end
				4'd3: begin
				   if(index<=6'd12) begin
					   if(reverse==1'b0) begin
					      out[index]<=1'b1;
							out[6'd25-index]<=1'b1;
						end
						else begin
						   out[index]<=1'b0;
							out[6'd25-index]<=1'b0;
						end
					end
					if(index>6'd12) begin
					   if(reverse==1'b0) begin
				         out[index-6'd13]<=1'b0;
							out[6'd25-(index-6'd13)]<=1'b0;
						end
						else begin
						   out[index-6'd13]<=1'b1;
							out[6'd25-(index-6'd13)]<=1'b1;
						end
					end
				   if(index<=6'd26 && reverse==1'b0) begin
					   index<=index+6'd1;
				      if(index==6'd26) begin
						   reverse<=1'b1;
							index<=index-6'd1;
						end
					end
					if(index>=6'd0 && reverse==1'b1) begin
					   index<=index-6'd1;
						if(index<=6'd0) begin
						   reverse<=1'b0;
							index<=6'd0;
							auto_next<=4'd4;
						end
					end
				end
				4'd4: begin
				   for(i=6'd0;i<=6'd25;i=i+6'd1) begin
					   if(reverse==1'b0) begin
						   if(i%2!=6'd0) out[i]<=1'b1;
							else out[i]<=1'b0;
						end
						if(reverse==1'b1) begin
						   if(i%2==6'd0) out[i]<=1'b1;
							else out[i]<=1'b0;
						end
					end
					reverse<=~reverse;
					if(index<=6'd25) index<=index+6'd1;
					else begin
					   index<=6'd27;
						auto_next<=4'd5;
					end
				end 
				4'd5: begin
					if(index<=6'd26) begin
					   out[index]<=1'b1;
						out[index+6'd1]<=1'b1;
					end
				   if(index<=6'd26) begin
					   index<=index+6'd2;
				      if(index==6'd26) begin
							index<=6'd0;
							out<=26'd0;
							auto_next<=4'd6;
						end
					end	
				end
				4'd6: begin
				   if(index<=6'd5) begin
					   out[index]<=1'b1;
					   out[6'd12-index]<=1'b1;
						out[6'd25-index]<=1'b1;
						out[6'd13+index]<=1'b1;
					end
					if(index==6'd6) begin
				      out[index]<=1'b1;
						out[6'd25-6'd6]<=1'b1;
					end
				   if(index<=6'd6) begin
					   index<=index+6'd1;
					end
					else begin
					   index<=6'd0;
						out<=26'd0;
						auto_next<=4'd7;
					end
				end
				4'd7: begin
				   if(index<=6'd13) begin
					   if((6'd12-index)%2==6'd0) out[6'd12-index]<=1'b1;
						else out[6'd12-index]<=1'b0;
					   if((6'd25-(6'd12-index))%2!=6'd0) out[6'd25-(6'd12-index)]<=1'b1;
						else out[6'd25-(6'd12-index)]<=1'b0;
					end
					if(index<=6'd13) begin
					   index<=index+6'd1;
						if(index==6'd13) begin
						   index<=6'd0;
							out<=26'd0;
							auto_next<=4'd8;
						end
					end
				end
				4'd8: begin
					if(index>=6'd0 && index<=6'd20) begin
					   out[index]<=1'b0;
						out[index+6'd1]<=1'b0;
						out[index+6'd2]<=1'b0;
						out[index+6'd3]<=1'b0;
					end
					if(index>=6'd24 && index<=6'd25) begin
					   out[index]<=1'b0;
						out[index+6'd1]<=1'b0;
					end
					if(index<=25) begin
					   if(index<=6'd20) index<=index+6'd4;
						else index<=index+6'd1;
						if(index==6'd25) begin
						   index<=6'd0;
							for(i=6'd0; i<=6'd25; i=i+6'd1) out[i]<=1'b1;
							auto_next<=4'd9;
						end
					end
				end
				4'd9: begin
	   			if(out==26'b11111111111111111111111111) out<=26'd0;
					else begin
               out[25]<=1'b1;	
    				if(index<=6'd24) begin
					   if(reverse==1'b0) begin
						   for(i=0; i<=6'd24; i=i+6'd1) begin
					      if(i==index) out[i]<=1'b1;
							else out[i]<=1'b0;
						   end
						end
						else begin
						   out[index]<=1'b1;
						end
					end
				   if(index<=6'd25 && reverse==1'b0) begin
					   index<=index+6'd1;
				      if(index==6'd25) begin
						   reverse<=1'b1;
							index<=index-6'd1;
						end
					end
					if(index>=6'd0 && reverse==1'b1) begin
					   index<=index-6'd1;
						if(index<=6'd0) begin
						   reverse<=1'b0;
							index<=6'd0;
							auto_next<=4'd0;
						end
					end
					end		
				end
				default: begin
				   for(i=6'd0; i<=6'd25; i=i+6'd1) begin
					   out[i]=1'b1;
					end
				end
			endcase
		end
	end
	
	clock_divider c_d2(clk, 3'd2, hz_led);
	
	always @(posedge hz_led) begin
	   if(countled<=3'd5) begin
		   countled<=countled+3'd1;
			if(countled>=3'd0 && countled<=3'd3) onled3210[countled]<=1'b1;
		end
		if(countled==3'd6) begin
		   countled<=3'd0;
			onled3210<=4'd0;
		end
	end
	
	led7_decoder l3(onled3210[0], 4'b1110, led3);
	led7_decoder l2(onled3210[1], 4'b1111, led2);
	led7_decoder l1(onled3210[2], 4'b0001, led1);
	led7_decoder l0(onled3210[3], 4'b1001, led0);
	
	assign controlled76[8:5]=mode_in/4'd10;
	assign controlled76[3:0]=mode_in%4'd10;
	assign controlled76[9]=(controlled76[8:5]==4'd0)? 1'b0:1'b1;
	assign controlled76[4]=1'b1;
	
	led7_decoder l7(controlled76[9], controlled76[8:5], led7);
	led7_decoder l6(controlled76[4], controlled76[3:0], led6);
	
	assign controlled54=(mode_hz==3'd0)? 10'b1000010101:
	                    (mode_hz==3'd1)? 10'b0000010001:
							  (mode_hz==3'd2)? 10'b0000010010:
							  (mode_hz==3'd3)? 10'b0000010100:
							  (mode_hz==3'd4)? 10'b0000011000:10'b0000011000;
							 
	led7_decoder l5(controlled54[9], controlled54[8:5], led5);
	led7_decoder l4(controlled54[4], controlled54[3:0], led4);
	
	assign out_auto=auto;
	
endmodule
	