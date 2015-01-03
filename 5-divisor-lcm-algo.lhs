> import Primes
> import Data.List

Problem: 2520 is the smallest number that can be divided by each of the numbers
 from 1 to 10 without any remainder.

 What is the smallest number that is evenly divisible by all of the numbers
 from 1 to 20?

Approach: for each prime p
		divide the list
		if (sum list == 0)
			done
		if (any one gets divided)
			emit the prime number
		else
			start with next prime


> rmod a b 
>	| a == 1	= 1
>	| otherwise	= b `mod` a

> rdiv a b = b `div` a

> condDiv b a
>	| mod a b /= 0	=	a
>	| otherwise	= 	a `div` b

> divisor xs x
>	| product modlist == 0	= [x] ++ divisor (map (condDiv x) xs) x
>	| otherwise		= []
>	where modlist = map (x `rmod`) xs

> calcLCM primes xs
>		| sum (map (rdiv (head primes)) xs) /= 0 = 
>			(divisor xs (head primes)) ++ (calcLCM (tail primes) nextxs)
>		| otherwise			         = []
>		where nextxs = eliminate (divisor xs (head primes)) xs
>
> eliminate factors list
>	| null factors	= list
>	| otherwise	= eliminate (tail factors) newList
>	where newList = map (condDiv (head factors)) list

> lcm = calcLCM primeSeq

To calculate, use: product $ take 30 $ calcLCM  primeSeq [1..20]
