*Poker*

The code includes a Zero-knowledge proof as part of a modified and simplified poker game. The game varies from regular poker in that bluffing is not allowed. Also, only pairs count for the purpose of evaluating and comparing hands. The proof ensures that a player (who has the choice of folding or bidding) may only bid if their hand contains one or more pairs. 

The circuit has the player's hand (face value only, suits are ignored) as private inputs. The player's bid is specified as public inputs: (fold, see, or raise). Constraints check that exactly one choice is made, and that if bidding, then the hand has a pair.

The player whose turn it is takes the role of prover. Other players may act as verifiers, once the player provides their proof.
