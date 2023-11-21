`timescale 1ns / 1ps
module match_timer(
input [3:0] row,
input [2:0] col,
input reset, switch,
output [7:0] COM, DATA
    );
reg i, k, clock;
reg [3:0] row1, row2, row3, row4, row5;
reg [2:0] col1, col2, col3, col4, col5;
reg [3:0] t1, t2, t3, t4, t5, t6, t7, t8;
initial begin
{row1, row2, row3, row4, row5} = 20'b11111111111111111111;
{col1, col2, col3, col4, col5} = 15'b111111111111111;
i = 1;
clock = 1;
end
always@(row, col) begin
    while(i) begin
        k = 0;
        if (row1 == 4'b1111 & col1 == 3'b111) begin
            row1 = row;
            col1 = col;
        end
        else
            if (row2 == 4'b1111 & col2 == 3'b111) begin
                row2 = row;
                col2 = col;
            end
            else
                if (row3 == 4'b1111 & col3 == 3'b111) begin
                    row3 = row;
                    col3 = col;
                end
                else
                    if (row4 == 4'b1111 & col4 == 3'b111) begin
                        row4 = row;
                        col4 = col;
                    end
                    else
                        if (row5 == 4'b1111 & col5 == 3'b111) begin
                            row5 = row;
                            col5 = col;
                        end
        if(row1 == 4'b1000 && col1 != 3'b010)
            k = 1;
        if(row2 == 4'b1000 && col2 != 3'b010)
            k = 1;
        if(row3 != 4'b0001)
            if(row3 != 4'b0010)
                k = 1;
            else if(row3 == 4'b0010)
                if(col3 == 3'b100)
                    k = 1;
        if(row4 == 4'b1000 && col4 != 3'b010)
            k = 1;
        if(row5 != 4'b1000 || col5 != 3'b001)
            k = 1;
        if(k == 1) begin
            {row1, row2, row3, row4, row5} = 20'b11111111111111111111;
            {col1, col2, col3, col4, col5} = 15'b111111111111111;
        end
        else
            i = 0;
    end
end
key_pad kp1(row1, col1, t1);
key_pad kp2(row2, col2, t2);
key_pad kp3(row3, col3, t3);
key_pad kp4(row4, col4, t4);
key_pad kp5(row1, col1, t5);
key_pad kp6(row2, col2, t6);
key_pad kp7(row3, col3, t7);
key_pad kp8(row4, col4, t8);
always@(*) begin
    #1000000000 clock = 0;
    #1000000000 clock = 1;
end       
always@(clock) begin
    t8 = t8 -1;
end
segment seg1(t1, 3'b111, COM, DATA);
segment seg2(t2, 3'b110, COM, DATA);
segment seg3(t3, 3'b101, COM, DATA);
segment seg4(t4, 3'b100, COM, DATA);
segment seg5(t5, 3'b011, COM, DATA);
segment seg6(t6, 3'b010, COM, DATA);
segment seg7(t7, 3'b001, COM, DATA);
segment seg8(t8, 3'b000, COM, DATA);
endmodule