class adder_sb;
    
  //creating mailbox handle
  mailbox mon2sb;
   
  //used to count the number of transactions
  int no_transactions;
  int failed_transactions;
  int correct_transactions;

  //constructor
  function new(mailbox mon2sb);
    //getting the mailbox handles from  environment
    this.mon2sb = mon2sb;

    no_transactions = 0;
    failed_transactions = 0;
    correct_transactions = 0;
  endfunction
   
  //Compares the Actual result with the expected result
  task run;
    adder_transaction trans;
    forever begin
        mon2sb.get(trans);
        if((trans.op_a + trans.op_b + 16*trans.carry_in) == (trans.sum + 16*trans.carry_out)) begin
            correct_transactions++;
        end else begin
            $error("Wrong Result.\n\tExpected: %0d Actual: %0d",
                (trans.op_a + trans.op_b + 16*trans.carry_in),
                (trans.sum + 16*trans.carry_out));
            failed_transactions++;
        end
        no_transactions++;
        //trans.display("[ Scoreboard ]");
    end
  endtask
   
endclass