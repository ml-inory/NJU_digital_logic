module demux8w4b(X, Y, F);
    input  [3:0] X;
    input  [2:0] Y;
    output reg [3:0] F [7:0];

    always @(*) begin
        case (Y)
            3'd0:   F[0] = X;
            3'd1:   F[1] = X;
            3'd2:   F[2] = X;
            3'd3:   F[3] = X;
            3'd4:   F[4] = X;
            3'd5:   F[5] = X;
            3'd6:   F[6] = X;
            3'd7:   F[7] = X;
        endcase
    end
  
endmodule