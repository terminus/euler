Problem 3: What is the largest prime factor of the number 600851475143?

> rmod a b = a `mod` b
> isPrime x xs
>	| total xs > 0 = False
>	| otherwise = True
>	where total xs = length $ filter (0 == ) $ map (x `rmod`) xs

> nextPrime x xs
> 	| isPrime x xs = x
> 	| otherwise    = nextPrime (x+2) xs

> prime :: Int -> [Int] -> [Int]
> prime upto xs 
>	  | next < upto = prime upto (xs ++ [next])
>	  | otherwise   = xs
>  	  where next = nextPrime (last xs + 2) xs

> factors number = [ x | x <- prime (number `div` 2) [2, 3], number `mod` x == 0 ]
