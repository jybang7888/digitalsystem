`timescale 1ns / 1ps
module key_pad(
    input [3:0] row,
    input [2:0] col,
    output [3:0] bi_num // 숫자 10은 *, 숫자 11은 #, 숫자 15는 기본값으로 처리
);
reg num;
initial begin
    num = 4'b1111;
end
always@(row, col) begin
    if (col == 4'b001)
        case(row)
            4'b0001: num = 4'b0001;
            4'b0010: num = 4'b0100;
            4'b0100: num = 4'b0111;
            4'b1000: num = 4'b1010;
            default: num = 4'b1111;
        endcase 
    else if (col == 4'b010)
        case(row)
            4'b0001: num = 4'b0010;
            4'b0010: num = 4'b0101;
            4'b0100: num = 4'b1000;
            4'b1000: num = 4'b0000;
            default: num = 4'b1111;
        endcase
    else if (col == 4'b100)
        case(row)
            4'b0001: num = 4'b0011;
            4'b0010: num = 4'b0110;
            4'b0100: num = 4'b1001;
            4'b1000: num = 4'b1011;
            default: num = 4'b1111;
        endcase
    else
        num = 4'b1111;
end
    assign bi_num = num;
endmodule