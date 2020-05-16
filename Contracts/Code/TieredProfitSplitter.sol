pragma solidity ^0.5.0;

/* //Level Two:  TIERED PROFIT SPLITTER CONTRACT/
 calculate rudimentary percentages for THREE different tiers of employees:
 CEO (60% of profit plus remainders)
 CTO (25% of profit)
 Bob (15% of profit)
*/
contract TieredProfitSplitter {
    address payable employee_one; // CEO
    address payable employee_two; // CTO
    address payable employee_three; // Bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // @TODO: Calculate and transfer the distribution percentage
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        amount = points * 60; 
        //Output value approximately equals to msg.value * 60% as uint points = msg.value / 100;
        //Alternatively, set uint points = msg.value; then amount = points * 0.6;

        // Step 2: Add the `amount` to `total` to keep a running total
        total += amount;

        // Step 3: Transfer the `amount` to `employee_one`
        employee_one.transfer(amount);
        //Note: amount = points * 60 for employee_one

        // @TODO: Repeat the previous steps for `employee_two` and `employee_three`

        // For  `employee_two`: 
        // Step 1: Based on the instruction, `employee_two` gets 25% of the points
        amount = points * 25;
        // Step 2: Add `amount` to `total` for a running total 
        total += amount;
        // Step 3: Transfer the `amount` to `employee_two`
        employee_two.transfer(amount);

        // For  `employee_three`: 
        // Step 1: Based on the instruction, `employee_three` gets 15% of the points
        amount = points * 15;
        // Step 2: Add `amount` to `total` for a running total 
        total += amount;
        // Step 3: Transfer the `amount` to `employee_three`
        employee_three.transfer(amount);


        // Transfer of leftover points to `employee_one`, i.e. the ceo.
        employee_one.transfer(msg.value - total); // ceo gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}
