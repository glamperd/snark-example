template Multiplier() {
   signal private input a;
   signal private input b;
   signal output c;
   signal inva;
   signal invb;
   signal output temp[5001];

   temp[0] <== 1;
   temp[1] <== 1;
   temp[2] <== 1;
   // Add lots of constraints
   for (var i=3; i<=5000; i++) {
      (i>a) --> temp[i];
      temp[i] === 1;
   }

   inva <-- 1/(a-1);
   (a-1)*inva === 1;
   invb <-- 1/(b-1);
   (b-1)*invb === 1;

   c <== a*b;
}

component main = Multiplier();
