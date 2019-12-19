module adder_tb;

    reg [3:0] a;
    reg [3:0] b;
    reg ci;
    wire [3:0] sum;
    wire co;

    environment env;
    adder_intf add_if();

    four_bit_adder adder(.op_a(add_if.op_a), 
                         .op_b(add_if.op_b), 
                         .carry_in(add_if.carry_in), 
                         .sum(add_if.sum), 
                         .carry_out(add_if.carry_out));


    initial begin
        env = new(add_if);
        env.run();
    end

    initial begin
        $display("Adder TB!");
        $display("+-----------------------------+");
        $display("|  a  |  b  | ci  | co  | sum |");
        $display("+-----------------------------+");
        $monitor("|  %h  |  %h  |  %h  |  %h  |  %h  |",
                 add_if.op_a, add_if.op_b, add_if.carry_in, add_if.carry_out, add_if.sum);
    end
endmodule