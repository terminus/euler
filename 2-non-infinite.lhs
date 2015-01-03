Problem 2: Find the sum of all the even-valued terms in the fibonacci sequence which do not exceed four million.

Step1: generate the fibonacci sequence

Keep generating till the term is <= 4 * 1000 * 1000
Infinite lazy fibonacci...

> nextFib :: [Int] -> Int
> nextFib = sum . fst . splitAt 2 . reverse

> fibonacci :: Int -> [Int] -> [Int]
> fibonacci upto xs 
>	  | next < upto = fibonacci upto (xs ++ [next])
>	  | otherwise   = xs
>  	  where next = nextFib xs

The rest is filtering for wanted elements...
