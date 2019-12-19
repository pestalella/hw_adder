class environment;
    virtual adder_intf vif;
    driver driv;
    generator gen;
    adder_sb scb;
    
    mailbox mon2scb;
    mailbox gen2drv;


    function new(virtual adder_intf vif);
        this.vif = vif;

        mon2scb = new();
        gen2drv = new();
        gen = new(gen2drv);
        driv = new(vif, gen2drv);
    endfunction

    task run;
        fork
            gen.run();
            driv.drive();
        join_any
        
    endtask

endclass