TODO: dirty, cleanup
This has gotten quite dirty. Can simplify.

> module Primes
> (
> primeSeq,
> primeFactors 
> ) where

Approach: generate infinite list of all primes, filter each of them with the
criteria that prime < x, prime `mod` x == 0.

> rmod a b = a `mod` b

What is it to be a prime number? All numbers below this number must have
a non-zero modulus with it.

> isqrt = floor . sqrt . fromIntegral
> isPrimeR x xs
>	| total xs > 0 = False
>	| otherwise = True
>	where total xs = length $ filter (0 == ) $ map (x `mod`) (takeWhile (\y -> y <= (isqrt x)) xs)

Primes cover all non primes. Thus, it's enough to check primality with only
other primes.

Thus we just need to keep growing our prime number list and check every next
number for primality. If prime add, otherwise move to the next one.

> addPrime x xs
> 	| isPrimeR x xs = [x]
> 	| otherwise    = [ ]

> primes x xs
>	| x == 2 	= [2] ++ primes 3 [2]
>	| x == 3	= [3] ++ primes (x+2) [2,3]
>	| otherwise 	= next ++ primes (x+2) (xs ++ next)
>	where next = addPrime x xs 
> primeSeq = primes 2 []

> primes2 x xs = next ++ primes2 (x+2) (xs ++ next)
> 		where next = addPrime x xs
> primeSeq2 = [2,3] ++ primes 5 [2,3]

> factors number ps
>  	| number `mod` firstP == 0 = [firstP] ++ (factors (number `div` firstP) ps)
>	| number == 1		   = [1]
>	| otherwise 		   = factors number (tail ps)
> 	where firstP = head ps
> primeFactors number = factors number primeSeq
