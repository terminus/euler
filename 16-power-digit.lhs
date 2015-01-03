todo: needs to be done without bigint

> enList num
>	| num == 0	= []
>	| otherwise	= (num `mod` 10) : enList (num `div` 10)
> result2 = (sum . enList)
