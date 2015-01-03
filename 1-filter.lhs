Problem: Find the sum of all the multiples of 3 or 5 below 1000.

Selection filter

> sumfilter :: Int -> Bool
> sumfilter x = (x < 1000 && ((x `mod` 3 == 0) || (x `mod` 5 == 0)))

> suitable :: Int -> [Int]
> suitable n = filter sumfilter [1..n-1]

Sum them up

> total :: Int -> Int
> total = sum . suitable
