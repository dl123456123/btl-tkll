module led7_decoder_tb;

reg [3:0] in;
reg on;
wire [6:0] out;

led7_decoder UUT(.on(on), .in(in), .out(out));
initial begin
on=1'b1;
in=4'b1001;
#10;
on=1'b1;
in=4'b1000;
#10;
on=1'b1;
in=4'b0111;
#10;
on=1'b1;
in=4'b0110;
#10;
on=1'b1;
in=4'b0101;
#10;
on=1'b1;
in=4'b0100;
#10;
on=1'b1;
in=4'b0011;
#10;
on=1'b0;
in=4'b0010;
#10;
on=1'b0;
in=4'b1010;
#10;
on=1'b1;
in=4'b0010;
#10;
on=1'b1;
in=4'b0001;
#10;
on=1'b1;
in=4'b0000;
#10;
on=1'b1;
in=4'b1111;
#10;
on=1'b1;
in=4'b1110;
#10;
end
endmodule 