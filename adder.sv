`ifndef ADDER_SV
`define ADDER_SV

module one_bit_full_adder (
    a,
    b,
    cin,
    sum,
    cout
);
    input a, b, cin;
    output sum, cout;

    assign sum = a ^ b ^ cin;
    assign cout = (a & cin) | (b & cin) | (a & b);
endmodule

module four_bit_adder (
    op_a, 
    op_b,
    carry_in,
    sum,
    carry_out
);
    input wire [3:0] op_a;
    input wire [3:0] op_b;
    input wire carry_in;
    output wire [3:0] sum;
    output wire carry_out;

    wire c1, c2, c3;

    one_bit_full_adder u0(.a(op_a[0]), .b(op_b[0]), .cin(carry_in), .sum(sum[0]),        .cout(c1));
    one_bit_full_adder u1(.a(op_a[1]), .b(op_b[1]),       .cin(c1), .sum(sum[1]),        .cout(c2));
    one_bit_full_adder u2(.a(op_a[2]), .b(op_b[2]),       .cin(c2), .sum(sum[2]),        .cout(c3));
    one_bit_full_adder u3(.a(op_a[3]), .b(op_b[3]),       .cin(c3), .sum(sum[3]), .cout(carry_out));
endmodule

`endif