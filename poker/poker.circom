include "../node_modules/circomlib/circuits/gates.circom";
include "../node_modules/circomlib/circuits/comparators.circom";

template Poker() {
   signal private input cards[5]; // Each 2..14
   signal input isFold; // 1 or 0
   signal input isSee; // 1 or 0
   signal input raise; // int
   signal output isValid; // 1 or 0
   // Intermediate results
   signal isBid;
   signal isRaise;
   signal hasPairs;

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
   component isZ = IsZero();
   component not1 = NOT();
   isZ.in <-- raise;
   not1.in <-- isZ.out;
   isRaise <-- not1.out;
   component or1 = OR();
   or1.a <-- isRaise;
   or1.b <-- isSee;
   isBid <-- or1.out;
   // Constraint: Must be either bid or fold: isBid XOR isFold = 1
   component xor1 = XOR();
   xor1.a <-- isFold;
   xor1.b <-- isBid;
   xor1.out === 1;
   // Constraint: numPairs must be > 0 if isBid = 1
   component isZ2 = IsZero();
   isZ2.in <-- numPairs;
   component not2 = NOT();
   not2.in <-- isZ2.out;
   hasPairs <-- not2.out;
   component or2 = OR();
   or2.a <-- isFold;
   or2.b <-- hasPairs;
   or2.out === 1;

   //component and1 = AND();
   //and1.a <-- xor1.out;
   //and1.b <-- or2.out;
   //isValid <-- and1.out;
   //isValid === 1;
   isValid <== hasPairs;

}

component main = Poker();
