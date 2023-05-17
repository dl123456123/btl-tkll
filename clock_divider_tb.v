module clock_divider_tb;

reg clk;
reg [2:0] mode_hz;
wire hz_out;

clock_divider UUT(.clk(clk), .mode_hz(mode_hz), .hz_out(hz_out));
always
begin
 clk = 1'b1;
 #5;
 clk = 1'b0;
 #5;
end

initial begin
mode_hz = 3'b000;
#100;
mode_hz = 3'b001;
#100;
mode_hz = 3'b010;
#100;
mode_hz = 3'b011;
#100;
mode_hz = 3'b100;
#100;
mode_hz = 3'b111;
end 
endmodule 