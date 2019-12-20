`ifndef ENV_SVH
`define ENV_SVH

`include "adder_interface.sv"
`include "adder_sb.sv"
`include "driver.sv"
`include "generator.sv"
`include "monitor.sv"

class environment;
    virtual adder_intf vif;
    driver driv;
    generator gen;
    adder_sb scb;
    monitor mon;
    
    mailbox mon2sb;
    mailbox gen2drv;

    function new(virtual adder_intf vif);
        this.vif = vif;

        mon2sb = new();
        gen2drv = new();
        gen = new(gen2drv);
        driv = new(vif, gen2drv);
        mon = new(vif, mon2sb);
        scb = new(mon2sb);
    endfunction

    task run;
        fork
            gen.run();
            driv.drive();
            mon.run();
            scb.run();
        join_any
    endtask

endclass

`endif