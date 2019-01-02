include "../node_modules/circomlib/circuits/gates.circom";
include "../node_modules/circomlib/circuits/comparators.circom";

template Poker() {
   signal private input cards[5]; // Each 2..14
   signal input isSee; // 1 or 0
   signal input raise; // int
   signal input isFold; // 1 or 0
   signal output out; // 1 or 0
   // Intermediate results
   signal isBid;
   signal isRaise;
   signal check1;

   // Count pairs
   var numPairs = 0;
   for (var i=0; i<4; i++) {
    for (var j=i+1; j<5; j++) {
      if (cards[i] == cards[j]) {
        numPairs++;
        //break; // 3-or-4-of-a-kind counts as 1 pair
        // break doesn't work. Just force j and i to exit
        j = 5;
        i = 5;
      }
    }
   }
   // isRaise = (raise != 0)
   isRaise <-- (raise > 0);
   isBid <-- (isRaise || isSee);

   // Constraint: Must be either bid or fold: isBid XOR isFold = 1
   check1 <-- isBid + isFold - 2*isBid*isFold;
   check1  === 1;

   // Constraint: numPairs must be > 0 if isBid = 1
   var hasPairs = (numPairs > 0);
   component not3 = NOT();
   not3.in <-- isBid;

   component or2 = OR();
   or2.a <-- hasPairs;
   or2.b <-- not3.out;
   or2.out === 1;

   component and1 = AND();
   and1.a <-- check1;
   and1.b <-- or2.out;
   out <-- or2.out;
   out === 1;
}

component main = Poker();
