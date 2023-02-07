/* verilator lint_off UNOPTFLAT */
/* verilator lint_off PINMISSING */
module alu(a, b, op, add_out, sub_out, not_out, and_out, or_out, xor_out, lt, eq);
    input [3:0] a;
    input [3:0] b;
    input [2:0] op;
    output [3:0] add_out;
    output [3:0] sub_out;
    output [3:0] not_out;
    output [3:0] and_out;
    output [3:0] or_out;
    output [3:0] xor_out;
    output lt;
    output eq;

    wire [3:0] a_out [7:0];
    wire [3:0] b_out [7:0];

    demux8w4b dmux_a(a, op, a_out);
    demux8w4b dmux_b(b, op, b_out);

    full_adder_4b adder(
        .a  (a_out[0]),
        .b  (b_out[0]),
        .cin (),
        .sum    (add_out)
    );

    sub_4b sub1(
        .a  (a_out[1]),
        .b  (b_out[1]),
        .cin (),
        .sum (sub_out)
    );

    assign not_out = ~a_out[2];

    assign and_out = a_out[3] & b_out[3];

    assign or_out = a_out[4] | b_out[4];

    assign xor_out = a_out[5] ^ b_out[5];

    // 异号
    wire diff_sign_out = (a_out[6][3] ^ b_out[6][3]) & ((~(~a_out[6][3] & b_out[6][3])) | (a_out[6][3] & ~b_out[6][3]));
    wire [3:0] sub2_out;
    sub_4b sub2(
        .a  (a_out[6]),
        .b  (b_out[6]),
        .cin (),
        .sum (sub2_out)
    );
    assign lt = (~(a_out[6][3] ^ b_out[6][3])) & sub2_out[3] | diff_sign_out;

    sub_4b sub3(
        .a (a_out[7]),
        .b (b_out[7]),
        .cin (),
        .zero (eq)
    );

endmodule