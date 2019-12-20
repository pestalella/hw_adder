`ifndef DRIVER_SV
`define DRIVER_SV

`include "adder_interface.sv"
`include "adder_trans.sv"

class driver;
    mailbox gen2driv;
    virtual adder_intf vif;

    function new(virtual adder_intf vif, mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task drive;
        forever begin
            adder_transaction trans;
            #10 gen2driv.get(trans);
            vif.op_a     <= trans.op_a;
            vif.op_b     <= trans.op_b;
            vif.carry_in <= trans.carry_in;
            #1 -> transaction_done;
        end
    endtask
endclass

`endif