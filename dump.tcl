database -open waves -into waves.shm -default
probe -create -shm adder_tb -depth all -all
run
exit
