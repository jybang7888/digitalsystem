`timescale 1ns / 1ps
module SevenSeg_CTRL(
   iSEG7,
   iSEG6,
   iSEG5,
   iSEG4,
   iSEG3,
   iSEG2,
   iSEG1,
   iSEG0,
   oS_COM,
   oS_ENS
);
input [7:0] iSEG7, iSEG6, iSEG5, iSEG4, iSEG3, iSEG2, iSEG1, iSEG0;
output [7:0] oS_COM;
output [7:0] oS_ENS;
reg [7:0] oS_COM;
reg [7:0] oS_ENS;
integer CNT_SCAN;
always @(*)
begin
           if ( CNT_SCAN >= 7)
         CNT_SCAN = 0;
      else
         CNT_SCAN = CNT_SCAN + 1;

         case (CNT_SCAN)
      0 :
        begin
            oS_COM <= 8'b11111110;
            oS_ENS <= iSEG0;
        end                 1 :
        begin
            oS_COM <= 8'b11111101;
            oS_ENS <= iSEG1;
        end 
                2 :
        begin
            oS_COM <= 8'b11111011;
            oS_ENS <= iSEG2;
        end 
                3 :
        begin
            oS_COM <= 8'b11110111;
            oS_ENS <= iSEG3;
        end 
                4 :
        begin
            oS_COM <= 8'b11101111;
            oS_ENS <= iSEG4;
        end 
                5 :
        begin
            oS_COM <= 8'b11011111;
            oS_ENS <= iSEG5;
        end 
                6 :
        begin
            oS_COM <= 8'b10111111;
            oS_ENS <= iSEG6;
        end 
                7 :
        begin
            oS_COM <= 8'b01111111;
            oS_ENS <= iSEG7;
        end 
                default :
        begin
            oS_COM <= 8'b11111111;
            oS_ENS <= iSEG7;
        end
         endcase
   end

endmodule


module segment
(
   val, place,
   SEG_COM, SEG_DATA
);
input [3:0] val;
input [2:0] place;
output [7:0] SEG_COM, SEG_DATA;
reg [6:0] p0 = 7'b0, p1 = 7'b0, p2 = 7'b0, p3 = 7'b0, p4 = 7'b0, p5 = 7'b0, p6 = 7'b0, p7 = 7'b0;
BCD_to_7segment u1(val[3], val[2],val[1],val[0], A, B, C, D, E, F, G);
always@(*)begin
    case(place)
        3'b111: p0 = {A, B, C, D, E, F, G};
        3'b110: p1 = {A, B, C, D, E, F, G};
        3'b101: p2 = {A, B, C, D, E, F, G};
        3'b100: p3 = {A, B, C, D, E, F, G};
        3'b011: p4 = {A, B, C, D, E, F, G};
        3'b010: p5 = {A, B, C, D, E, F, G};
        3'b001: p6 = {A, B, C, D, E, F, G};
        3'b000: p7 = {A, B, C, D, E, F, G};
        default: {p0, p1, p2, p3, p4, p5, p6, p7} = 56'b0;
    endcase
end
SevenSeg_CTRL u2(p0, p1, p2, p3, p4, p5, p6, p7, SEG_COM, SEG_DATA);
endmodule

module BCD_to_7segment(T3, T2, T1, T0, A1, B1, C1, D1, E1, F1, G1);
input T3, T2, T1, T0;
output A1, B1, C1, D1, E1, F1, G1;
reg [6:0] out;
always @(T3, T2, T1, T0)
begin
case({T3, T2, T1, T0})
4'b0000 : out <= 7'b1111110;
4'b0001 : out <= 7'b0110000;
4'b0010 : out <= 7'b1101101;
4'b0011 : out <= 7'b1111001;
4'b0100 : out <= 7'b0110011;
4'b0101 : out <= 7'b1011011;
4'b0110 : out <= 7'b1011111;
4'b0111 : out <= 7'b1110010;
4'b1000 : out <= 7'b1111111;
4'b1001 : out <= 7'b1111011;
default : out <= 7'b0000000;
endcase
end
assign {A1, B1, C1, D1, E1, F1, G1} = out;
endmodule