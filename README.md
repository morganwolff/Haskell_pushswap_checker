# Haskell_pushswap_checker <br>

The goal of this project is to produce a program capable to check if a sequence of push_swap operations
effectively sorts a list of integers. <br>
echo "Operations" | ./pushswap_checker (randomNumbers)

# Exemple: <br>

echo "ra pb pb ra pb rra pb rra rra pb rra pb pb pa pa pa pa pa pa pa" | ./pushswap_checker 19 -1 2 5 4 33 10 9 <br>
OK <br>
([-1,2,4,5,9,10,19,33],[]) <br>