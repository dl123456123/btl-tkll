module runningled_m2(clk, out);
   input clk;
	output reg [25:0] out=26'd0;
   reg [5:0] i=6'd0,index=6'd0;
	reg reverse=1'b0;
	
   always @(posedge clk) begin
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
	end
        end
                          end	


	end
endmodule
