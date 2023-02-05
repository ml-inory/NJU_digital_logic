module encode83(x, en, y, seg);
    input [7:0] x;
    input en;
    output reg [2:0] y;
    output [6:0] seg;
    integer i;

    bcd7seg show_seg({1'b0, y}, seg);

    always @(*) begin
        if (en) begin
            y = 3'b000;
            for (i = 0; i < 8; i = i + 1)
                if (x[i] == 1)  y = i[2:0];
        end
        else y = 3'b000;
    end

endmodule