module Ficha04 where
import Data.Char (isDigit , isAlpha)



--1) enumeraçao da lista correspondente

--a) [x | x <- [1..20], mod x 2 == 0, mod x 3 == 0]
-- [6,12,18]

--b) [x | x <- [y | y <- [1..20], mod y 2 == 0], mod x 3 == 0]
-- [6,12,18]

--c) [(x,y) | x <- [0..20], y <- [0..20], x+y == 30]
-- [(10,20),(11,19),(12,18),(13,17),(14,16),(15,15),(16,14),(17,13),(18,12),(19,11),(20,10)]

--d) [sum [y | y <- [1..x], odd y] | x <- [1..10]]
-- [1,1,4,4,9,9,16,16,25,25]

--2) Defina cada uma das listas seguintes por compreensao.

--a) [1,2,4,8,16,32,64,128,256,512,1024]
-- [x | 2^x <- [1..10]]

--b) [(1,5),(2,4),(3,3),(4,2),(5,1)]
-- [(x,y) | x <- [1..5], y <- [1..5], x + y == 6]

--c) [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]
-- [[1..x] | x <- [1..5]]

--d) [[1],[1,1],[1,1,1],[1,1,1,1],[1,1,1,1,1]]
-- [replicate x 1 | x <- [1..5]]

--e) [1,2,6,24,120,720]
-- [x | fatorial x <- [1..5]]

--3) dada uma string, devolve um par de strings: uma apenas com as letras presentes nessa string, e a outra apenas com os numeros presentes na string. 

digitAlpha :: String -> (String,String)
digitAlpha "" = ("","")
digitAlpha (h:t) | isAlpha h = (h:a,b)
                 | isDigit h = (a,h:b)
                 where
                    (a,b) = digitAlpha t

--4) dada uma lista de inteiros, conta o numero de valores nagativos, o numero de zeros e o numero de valores positivos, devolvendo um triplo com essa informaçao.

nzp :: [Int] -> (Int,Int,Int) 
nzp [] = (0,0,0)
nzp (h:t) | h<0 = ((a+1),b,c)
          | h==0 = (a,(b+1),c)
          | otherwise = (a,b,(c+1))
        where
            (a,b,c) = nzp t 

--5) calcula simultaneamente a divisao e o resto da divisao inteira por subtraçoes sucessivas.

--divMod' :: Integral a => a -> a -> (a, a)
--divMod' x y = aux x y (0,0)

--aux :: Integral a => a -> a -> (a,a) -> (a,a)
--aux x y (z1,z2) = if (x-y < 0) then (z1,x) else aux (x-y) y (z1+1,z2)

-----------------------------------------------------

divMod' :: Integral a => a -> a -> (a, a)
divMod' x y = aux x y (0,0)
            where
                aux :: Integral a => a -> a -> (a,a) -> (a,a)
                aux x y (z1,z2) = if (x-y < 0) then (z1,x) else aux (x-y) y (z1+1,z2)

------------------------------------------------------

--6) Utilizando uma funçao auxiliar com um acumulador, optimize seguinte definiçao recursiva que determina qual o numero que corresponde a uma lista de digitos.

--fromDigits :: [Int] -> Int
--fromDigits [] = 0
--fromDigits (h:t) = h*10^(length t) + fromDigits t

fromDigits :: [Int] -> Int
fromDigits = foldl (\acc x -> x + 10 * acc) 0

--7) Utilizando uma funçao auxiliar com acumuladores, optimize seguinte definiçao que determina a soma do segmento inicial de uma lista com soma maxima.

--maxSumInit :: (Num a, Ord a) => [a] -> a
--maxSumInit l = maximum [sum m | m <- inits l]

maxSumInit :: (Num a,Ord a) => [a] -> a
maxSumInit (x:xs) = if x > 0 then aux x x xs else aux 0 x xs
  where
    aux maximo _ [] = maximo
    aux maximo acc (y:ys) = if acc+y > maximo
      then aux (acc+y) (acc+y) ys
      else aux maximo (acc+y) ys

--8) Optimize a seguinte definiçao recursiva da funçao que calcula o n-ésimo numero da sequencia de Fibonacci, usando uma funçao auxiliar com 2 acumuladores que representam, respectivamente, o n-ésimo e o n+1-ésimo numeros dessa sequencia.

--fib :: Int -> Int
--fib 0 = 0
--fib 1 = 1
--fib n = fib (n-1) + fib (n-2)

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
--fib acc = [fib acc | acc <- (acc-1)+(acc-2)]

-----------------------------------------------------


