`ifndef GENERATOR_SV
`define GENERATOR_SV

`include "adder_trans.sv"

class generator;
    adder_transaction trans;
    mailbox gen2driv;

    function new(mailbox gen2driv);
        this.gen2driv = gen2driv;
    endfunction

    task run;
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                trans = new();
                trans.op_a = i;
                trans.op_b = j;
                trans.carry_in = 0;
                gen2driv.put(trans);
            end
        end
        -> generation_done;
        $display("-- GENERATOR COMPLETED");
    endtask
endclass

`endif