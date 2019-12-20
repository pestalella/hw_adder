`ifndef MONITOR_SV
`define MONITOR_SV

`include "adder_trans.sv"

class monitor;

    mailbox mon2sb;
    virtual adder_intf vif;

    function new(virtual adder_intf vif, mailbox mon2sb);
        this.vif = vif;
        this.mon2sb = mon2sb;
    endfunction

    task run();
        adder_transaction trans;
        forever begin
            @(transaction_done)
            trans = new();
            trans.op_a = vif.op_a;
            trans.op_b = vif.op_b;
            trans.carry_in = vif.carry_in;
            trans.sum = vif.sum;
            trans.carry_out = vif.carry_out;
            mon2sb.put(trans);
        end

    endtask

endclass

`endif