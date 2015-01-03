Problem: Find the sum of all the multiples of 3 or 5 below 1000.

Using simple list comprehension.

Find the suitable numbers

> suitable n = [ x | x <- [1..n-1], x `mod` 3 == 0 || x `mod` 5 == 0 ]

Sum them up

> total = sum . suitable
