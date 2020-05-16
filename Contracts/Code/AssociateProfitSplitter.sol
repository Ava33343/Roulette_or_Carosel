pragma solidity ^0.5.0;

/* /Level One: EQUAL SPLIT/
Profit distributed equally among employees
*/
contract AssociateProfitSplitter {

    address payable employee_one = 0x0616d31438078849D3bf66591855B3D3239a9E5c;
    address payable employee_two = 0x5DBaBe19DD1fedba1B20047059DCd755D8221BF7;
    address payable employee_three = 0x3e9D41Ec700b98C773f2599052a3590931bEa98c;

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // @TODO: Split `msg.value` into three
        uint amount = msg.value/3; 

        // @TODO: Transfer the amount to each employee
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);


        // @TODO: take care of a potential remainder by sending back to HR (`msg.sender`)
        msg.sender.transfer(msg.value - 3*amount);
    }

    function() external payable {
        // @TODO: Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}
