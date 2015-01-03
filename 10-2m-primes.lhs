> import Primes

> solution = sum $ takeWhile (\x -> x < 2000000) primeSeq

> main = print $ solution
