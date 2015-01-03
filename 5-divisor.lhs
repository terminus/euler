TODO: dirty, redo, librarify, related:problem-8

This is uglier than sin. First uses prime factors because, well, we had prime
factor code ready.  Then it does some horrible stuff with tuples and combining
of tuples and then pruning them.

> import Primes
> import Data.List

Problem: 2520 is the smallest number that can be divided by each of the numbers
 from 1 to 10 without any remainder.

 What is the smallest number that is evenly divisible by all of the numbers
 from 1 to 20?

Approach:
   - find factors of each number from [1..20]
   - find the union of all the factors
   - product

> factorize [] = []
> factorize xs = [primeFactors (head xs)] ++ factorize (tail xs)

We always start with xs = [1] (common factor.) That way we don't need to
handle the xs = [] case.

> merge xs []       	= xs
> merge xs (ys:[])	= union xs ys
> merge xs yss		= merge (union xs (head yss)) (tail yss)

product $ merge [1] (reverse $ factorize [1..20]) would do it.

Actually this won't do it. This just gives us the set of primes in [1..20].
What we need is a multiset or something.

What we need is a different representation. Tupled factors or something.

All that we need is an LCM program.
LCM of a, b: 
	find count of each prime factor of a
	find count of each prime factor of b
	merge prime factors of all the numbers
		for each prime factor in a, b

> count elem xs = sum [1 | x <- xs, elem == x]
> congeal [] = []
> congeal (x:[]) = [(x,1)]
> congeal (x:xs) = [(x, 1 + count x xs)] ++ congeal xs

> unifyX :: [(Integer,Integer)] -> [(Integer,Integer)]
> unifyX = (nubBy (\a b -> ((fst a == fst b))))

[(1,1), (2,5), (3,4)] [1..10]

unionBy                 :: (a -> a -> Bool) -> [a] -> [a] -> [a]
unionBy eq xs ys        =  xs ++ foldl (flip (deleteBy eq)) (nubBy eq ys) xs
flip :: (a -> b -> c) -> b -> a -> c
deleteBy          -- :: (a -> a -> Bool) -> a -> [a] -> [a]
nubBy             -- :: (a -> a -> Bool) -> [a] -> [a]

 unionX xs ys = [(a,c) | a == b, (a, c) <- xs, (b, c) <- ys, a == b,
			where c = c1 `max` c2]
 [(1,1), (2,5), (3,4)]
								  [(1,1), (2,6), (3,2)]

> merge2 cs []       	= cs
> merge2 cs (ys:[])	= cs ++ congeal ys
> merge2 cs yss		= merge2 (cs ++ (congeal . head) yss) (tail yss)

> comparator x y 
>	| fst x > fst y = GT
>	| fst x == fst y && snd x < snd y = GT
>	| otherwise	= LT

unifyX (sortBy comparator (merge2 [] (factorize [1..20])))
would give the semifinal result.

> expand :: [(Integer,Integer)] -> [Integer]
> expand [] 	= []
> expand (x:xs) = ((fst x)^(snd x)) : expand xs

This expression does it
product . expand $ unifyX (sortBy comparator (merge2 [] (factorize [1..20])))

Note: These lists are kind of similar but the list comprehension needed for
both is different:
	Main> :t [[2],[3],[4]]                                                             
	[[2],[3],[4]] :: (Num t) => [[t]]                                                   
	*Main> :t [1:[3]]                                                                   
	[1:[3]] :: (Num t) => [[t]]       
