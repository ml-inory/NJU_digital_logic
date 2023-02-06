module encode83(x, en, y, seg, sig);
    input [7:0] x;
    input en;
    output reg [2:0] y;
    output [6:0] seg;
    output reg sig;
    integer i;

    bcd8seg show_seg({1'b0, y}, {seg, 1'b0});

    always @(*) begin
        if (en) begin
            y = 0;
            sig = 0;
            for (i = 0; i < 8; i = i + 1)
                if (x[i] == 1)  begin 
                    y = i[2:0];
                    sig = 1;
                end
        end
        else begin 
            y = 0;
            sig = 0;
        end
    end

endmodule