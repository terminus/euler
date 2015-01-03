> import Primes

Problem:
 A palindromic number reads the same both ways. The largest palindrome
 made from the product of two 2-digit numbers is 9009 = 91 x 99.  Find the
 largest palindrome made from the product of two 3-digit numbers.

 Range for palindrom: 10000 -- 998001

Approach 1:
 Find the largest 6 digit palindrome, find its prime factors and then multiply
 those prime factors to yield two 3 digit numbers.

 If we find one, done; otherwise move on to the next highest palindrome.

  Strategy:
      - Generate 6 digit palindromes lazily.
	. isPalindrome function
      	. Start with 999,999. Keep subtracting one digit until palindrome.
      - Generate corresponding factors.
      - Congeal factors into 3 digit multipliers.


> stringify 0 = []
> stringify x = stringify (x `div` 10) ++ [x `mod` 10]

> isPalindrome x = and $ zipWith (\a b -> a == b) (stringify x) (reverse $ stringify x)

> findPalindromes start end
>	| start < end		     = []
>	| isPalindrome start == True = [start] ++ findPalindromes (start - 1) end
>	| otherwise		     = findPalindromes (start - 1) end

> factorize [] = []
> factorize xs = [primeFactors (head xs)] ++ factorize (tail xs)

> greedy product []     = product
> greedy product (x:xs)
>		| (fst product * x) < 1000 = greedy (x * fst product, snd product) xs
>		| (snd product * x) < 1000 = greedy (fst product, x * snd product) xs
>		| otherwise		   = (fst product, x * snd product)

> factorList = factorize $ findPalindromes (999*999) (100*100)

> threeDigit fs = [prod] ++ (threeDigit . tail) fs
>		where prod = greedy (1,1) $ head fs

>--		| (fst prod * snd prod) == (product . head) fs  = [prod] ++ (threeDigit . tail) fs
>--		| otherwise					= [prod] ++ (threeDigit . tail) fs
>--		where prod = greedy (1,1) $ head fs
