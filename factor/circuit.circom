template Multiplier() {
   signal private input a;
   signal private input b;
   signal output c;
   signal inva;
   signal invb;

   inva <-- 1/(a-1);
   (a-1)*inva === 1;
   invb <-- 1/(b-1);
   (b-1)*invb === 1;
   
   c <== a*b;
}

component main = Multiplier();
