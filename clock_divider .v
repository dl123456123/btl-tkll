module clock_divider(clk, mode_hz, hz_out);
 input clk;
 input [2:0] mode_hz;
 output reg hz_out=1'b0;
 reg [27:0] counter;
 reg [27:0] temp;
always @(posedge clk) begin
 case(mode_hz)
 3'b0: begin
 temp<=28'd50_000_000*28'd2/28'd2;
 if(counter<=temp-28'd1) counter<=counter+28'd1;
 else counter<=28'b0;
 if(counter==28'd0) hz_out<=~hz_out;
 end
 3'b001: begin
 temp<=28'd50_000_000/28'd2;
 if(counter<=temp-28'd1) counter<=counter+28'd1;
 else counter<=28'd0;
 if(counter==28'd0) hz_out<=~hz_out;
 end
 3'b010: begin
 temp<=28'd50_000_000/28'd2/28'd2;
 if(counter<=temp-28'd1) counter<=counter+28'd1;
 else counter<=28'd0;
 if(counter==28'd0) hz_out<=~hz_out;
 end
 3'b011: begin
 temp<=28'd50_000_000/28'd4/28'd2;
 if(counter<=temp-28'd1) counter<=counter+28'd1;
 else counter<=28'd0;
 if(counter==28'd0) hz_out<=~hz_out;
 end
 3'b100: begin
 temp<=28'd50_000_000/28'd8/28'd2;
 if(counter<=temp-28'd1) counter<=counter+28'd1;
 else counter<=28'd0;
 if(counter==28'd0) hz_out<=~hz_out;
 end 
 default: begin
 temp<=28'd50_000_000/28'd8/28'd2;
 if(counter<=temp-28'd1) counter<=counter+28'd1;
 else counter<=28'd0;
 if(counter==28'd0) hz_out<=~hz_out;
 end
 endcase
 end
 endmodule
