module led7_decoder(on, in, out);
 input [3:0] in;
 input on; 
 reg [6:0] outcc;
 output [6:0] out;
 parameter zero=7'b1111110,
 one=  7'b0110000,
 two=  7'b1101101,
 three=7'b1111001,
 four= 7'b0110011,
 five= 7'b1011011,
 six=  7'b1011111,
 seven=7'b1110000,
 eight=7'b1111111,
 nine= 7'b1111011,
 e=    7'b1001111,
 c=    7'b1001110;
always @(*) begin 
 if(on) begin
 case (in) 
 4'b0000: outcc = zero ; 
 4'b0001: outcc = one  ;
 4'b0010: outcc = two  ;
 4'b0011: outcc = three;
 4'b0100: outcc = four ;
 4'b0101: outcc = five ;
 4'b0110: outcc = six  ;
 4'b0111: outcc = seven;
 4'b1000: outcc = eight;
 4'b1001: outcc = nine ;
 4'b1110: outcc = c    ;
 4'b1111: outcc = e    ;
 default: outcc = e    ; //e: error
 endcase
end
else outcc=7'b0;
 end
 not a1[6:0] (out,outcc);
endmodule 