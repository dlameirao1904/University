module Exame_18_19 where


--1. Apresente uma definiçao recursiva das seguintes funçoes sobre listas:

--(a) isSorted :: (Ord a) => [a] -> Bool que testa se uma lista esta ordenada por ordem crescente.

isSorted :: (Ord a) => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (h:x:t) | h>x = False
                 | otherwise = isSorted (x:t)

--(b) inits :: [a] -> [[a]] que calcula a lista dos prefixos de uma lista. Por exemplo, inits [11,21,13] corresponde a [[],[11],[11,21],[11,21,13]].

inits :: [a] -> [[a]]
inits [] = [[]]
inits l = inits (init l) ++ [l]

--2--Defina maximumMB :: (Ord a) => [Maybe a] -> Maybe a que da o maior elemento de uma lista de elementos do tipo Maybe a. Considere Nothing o menor dos elementos
{-
maximumMB :: (Ord a) => [Maybe a] -> Maybe a
maximumMB [] = (Nothing)
maximumMB [(Nothing),(Just a)] = (Just a)
maximumMB [(Just a),(Just b)] | a>b = (Just a)
                              | a<b = (Just b)
                              | otherwise = (Nothing)
maximumMB (h:x:t) | h==(Just a) && x==(Just b) && a>b = maximumMB (h:t)
                  | h==(Just a) && x==(Just b) && a<b = maximumMB (x:t)
                  | h==(Just a) && x==(Just b) && a==b = maximumMB t 
-}
--3

data LTree a = Tip a | Fork (LTree a) (LTree a)

--a)Defina a funçao listaLT :: LTree a -> [a] que da a lista das folhas de uma ´arvore (da esquerda para a direita).

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork l r) = listaLT l ++ listaLT r

--Defina uma instˆancia da classe Show para este tipo que
--apresente uma folha por cada linha, precedida de tantos
--pontos quanta a sua profundidade na ´arvore. Veja o
--exemplo ao lado.


-- > Fork (Fork (Tip 7) (Tip 1)) (Tip 2)
-- ..7
-- ..1
-- .2

replicar :: Int -> a ->[a]
replicar 0 _ = []
replicar n x = x:replicar (n-1) x

instance Show a => Show (LTree a) where
    show (Tip a) = "\n" ++ show a 
    show (Fork l r) = (kpontos 1 l) ++ (kpontos 1 r)
                    where 
                       kpontos :: Show a => Int -> LTree a -> String
                       kpontos n (Tip a) = "\n" ++ replicar n '.' ++ show a 
                       kpontos n (Fork l r) = (kpontos (n+1) l) ++ (kpontos (n+1) r)

arvore1 = Fork (Fork (Tip 7) (Tip 1)) (Tip 2)

--4. Utilizando uma funçao auxiliar com acumuladores, optimize a seguinte definiçao que determina a soma
--do segmento inicial de uma lista com soma maxima.

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l = maximum [sum m | m <- inits l]

maxSumInit' :: (Num a, Ord a) => [a] -> a
maxSumInit' l = foldl (\acc x -> max (sum x) acc) (sum l) (inits l)

--5

type RelP a = [(a,a)]
type RelL a = [(a,[a])]
type RelF a = ([a], a -> [a])

--a)

convLP :: RelL a -> RelP a
convLP l = concat (map junta l)
where junta (x,xs) = map (\y->(x,y)) xs








