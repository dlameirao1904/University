module Teste_1617 where

import Data.Maybe (fromMaybe)

--1)

type MSet a = [(a,Int)]

--a) calcula a cardinalidade de um multiconjunto.

cardMSet :: MSet a -> Int
cardMSet [] = 0
cardMSet ((c,n):t) = n + cardMSet t

--b) devolve a lista dos elementos com maior numero de ocorrencias.

moda :: MSet a -> [a]
moda [] = []
moda [(a,n)] = [a]
moda [(a,n),(b,k)] = if n>k then [a] else [b]
moda ((a,n):(b,k):t) = if n>k then moda ((a,n):t) else moda ((b,k):t)

--c) converte um multi-conjunto numa lista.

converteMSet :: MSet a -> [a] 
converteMSet [] = []
converteMSet ((a,n):t) = (replicate n a) ++ (converteMSet t)

--d) faz a inserçao de um dado numero de ocorrencias de um elemento no multi-conjunto, mantendo a ordenaçao por ordem decrescente da multiplicidade

addNcopies :: Eq a => MSet a -> a -> Int -> MSet a
addNcopies [] x n = [(x,n)]
addNcopies ((h,k):t) x n = if x==h then ((h,k+n):t) else ((h,k) : addNcopies t x n)

--2

data SReais = AA Double Double | FF Double Double
            | AF Double Double | FA Double Double
            | Uniao SReais SReais

--a)Defina a SReais como instancia da classe Show, de forma a que, por exemplo, a apresentaçao
--do termo Uniao (Uniao (AA 4.2 5.5) (AF 3.1 7.0)) (FF (-12.3) 30.0) seja
--((]4.2,5.5[ U ]3.1,7.0]) U [-12.3,30.0])

instance Show SReais where
    show (Uniao a b) = "(" ++ show a ++ " U " ++ show b ++ ")"
    show intv = ch1 ++ num1 ++ "," ++ num2 ++ ch2
              where (ch1,num1,num2,ch2) = case intv of AA a b -> ("]",show a,show b,"[")
                                                       AF a b -> ("]",show a,show b,"]")
                                                       FA a b -> ("[",show a,show b,"[")
                                                       FF a b -> ("[",show a,show b,"]")

intervalo1 :: SReais
intervalo1 = Uniao (Uniao (AA 4.2 5.5) (AF 3.1 7.0)) (FF (-12.3) 30.0)

--b)testa se um elemento pertence a um conjunto.

pertence :: Double-> SReais -> Bool
pertence x (Uniao a b) = pertence x a || pertence x b
pertence x conjunto = (af1 && x >= x1 || x > x1) && (af2 && x <= x2 || x < x2)
    where (af1,x1,x2,af2) = case conjunto of AA a b -> (False,a,b,False)
                                             AF a b -> (False,a,b,True)
                                             FA a b -> (True,a,b,False)
                                             FF a b -> (True,a,b,True) 

--c) retira um elemento de um conjunto.

tira :: Double -> SReais -> SReais
tira x (Uniao a b) | pertence x a = Uniao (tira x a) b
                   | pertence x b = Uniao a (tira x b)
                   |otherwise = Uniao a b
tira x conjunto = case conjunto of (AA a b) -> if x==a then (AA a b) else if x==b then (AA a b) else if x>a && x<b then (Uniao (AA x a)(AA x b)) else conjunto
                                   (FF a b) -> if x==b then (FA a x) else if x==a then (AF a b) else if x>a && x<b then (Uniao (FF x a)(FF x b)) else conjunto
                                   (AF a b) -> if x==b then (AA a b) else if x==a then (AF a b) else if x>a && x<b then (Uniao (AF x a)(AF x b)) else conjunto 
                                   (FA a b) -> if x==b then (FA a b) else if x==a then (AA a b) else if x>a && x<b then (Uniao (FA x a)(FA x b)) else conjunto

--3)

data RTree a = R a [RTree a]

rtree1 = (R 1 [R 2 [], R 3 [R 4 [R 5 [], R 6 []]],R 7 []])

--a)recebe um caminho e
--uma arvore e da a lista de valores por onde esse caminho passa. Se o caminho nao for valido
--a funçao deve retornar Nothing. O caminho é representado por uma lista de inteiros (1 indica
--seguir pela primeira sub-arvore, 2 pela segunda, etc) 

percorre :: [Int] -> RTree a -> Maybe [a]
percorre [] (R a l) = Just [a]
percorre l (R a []) = Nothing
percorre (h:t) (R a l) | (length l)<h || null auxX= Nothing
                       | otherwise = Just (a:auxX)
            where 
                aux = percorre t (l !! (h-1))
                auxX = fromMaybe [] aux

--b)procura um elemento numa arvore e, em caso de sucesso, calcula o caminho correspondente.
{-
procura :: Eq a => a -> RTree a -> Maybe [Int]
procura x (R a l) | x==a = Just [a]
                  | null l = Nothing
                  | otherwise = foldl (\acc x -> if procura n (r!!(x-1)) == Nothing then acc else Just (x:fromMaybe [] (procura n (r !! (x-1))))) Nothing [1..length r]
-}

{-procura :: Eq a => a -> RTree a -> Maybe [Int]
procura _ (R [] []) = Nothing
procura x (R n t) 
               | x == n = Just [n]
               | elem x t == False = Nothing
               | elem x t = Just [n] : procura x t                 
-}


procura :: Eq a => a -> RTree a -> Maybe [Int]
procura x (R a l) | x==a = Just []
                  | null l = Nothing
                  | otherwise = (map (\r -> (procura x r)) l)                    







