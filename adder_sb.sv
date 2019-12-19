class adder_sb;
    
  //creating mailbox handle
  mailbox mon2scb;
   
  //used to count the number of transactions
  int no_transactions;
  int failed_transactions;
  int correct_transactions;
   
  //constructor
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment
    this.mon2scb = mon2scb;

    no_transactions = 0;
    failed_transactions = 0;
    correct_transactions = 0;
  endfunction
   
  //Compares the Actual result with the expected result
  task main;
    adder_transaction trans;
    forever begin
        mon2scb.get(trans);
        if((trans.op_a + trans.op_b + trans.carry_in) == (trans.sum + trans.carry_out)) begin
            correct_transactions++;
        end else begin
            $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",
                (trans.op_a + trans.op_b + trans.carry_in),
                (trans.sum + trans.carry_out));
            failed_transactions++;
        end
        no_transactions++;
        //trans.display("[ Scoreboard ]");
    end
  endtask
   
endclass