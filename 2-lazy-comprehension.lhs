Problem 2: Find the sum of all the even-valued terms in the
fibonacci sequence which do not exceed four million.


Let's try to generate a lazy list:

Given a fibonacci list, nextFib would give the next fibonacci
number:

> -- nextFib xs = (sum . fst . splitAt 2 . reverse) xs
> --  fibonacci xs =  fibonacci (xs ++ [nextfib xs])

However, this doesn't cut it.  This evaluates in full... The
problem was that this didn't really generate anything.

This is more correct:

> -- fibonacci xs =  xs ++ fibonacci (xs ++ [nextfib xs])

This works but generates the list multiple times:

> -- nextFib xs = (sum . fst . splitAt 2 . reverse) xs
> -- fibonacci xs =  xs ++ fibonacci (xs ++ [nextFib xs])

The problem is that the generator function in iteration n requires
the list from iteration n-1. Now, since the generator is recursive,
that implies that it will pass the n-list + the generated element
to it's child in iteration n+1.

Thus, at each stage the accumulated list gets passed forward.
And, the next guy generates a further list based on that.
Note that there is no way to actually get that list.

Except that we could just generate both the list and the
elements for further generation. We could get away with just
passing the top two elements though..

xs has only two elements.

> elementN_2 = reverse . tail . reverse
> elementN_1 = head . reverse
> elementN = sum . take 2 . reverse 

Fibonacci only ever takes a two element list. Leaves the first
one behind. Calculates the current one (based on the last two)
and passed the current and the old-second element.

> fibonacci xs = elementN_2 xs ++ fibonacci ([elementN_1 xs] ++ [elementN xs])

Works too. No repititions.  Not the cleanest though...

> sumFilter x = (x < 4000000  && x `mod` 2 == 0)
> solution = sum $ filter sumFilter $ take 100 $ fibonacci [1,2]

> main = print $ solution

The rest is filtering for wanted elements...
