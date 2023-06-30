module Recurso where

import Data.List
import Data.Char


type BD = [Video]

data Video = Filme String Int       -- título, ano

           | Serie String Int Int   -- título, temporada, episódio

           | Show  String Int       -- título, ano

           | Outro String

   deriving (Eq)

bd = [Filme "Diogo" 1, Filme "Daniela" 3]


 --1) Defina a função filmesAno :: Int -> BD -> [String] que indica os títulos dos filmes de um dado ano que existem na base de dados.

filmesAno :: Int -> BD -> [String]
filmesAno x [] = [""]
filmesAno x (h:t) = case h of (Filme nome n) -> if x==n then [nome] ++ filmesAno x t else filmesAno x t
                              otherwise      -> [""]


--2) Defina uma função que agrupe as pessoas por idade e ordene os grupos por ordem decrescente de idade
{-type ListaEspera = [(Nome,Idade)]

type Nome =String

type Idade = Int

agrupa :: ListaEspera -> [[(Nome,Idade)]]
agrupa [] = [[]]
agrupa ((n,i):(n2,i2):t) | i>i2 = [n,i] : agrupa ((n2,i2):t)
                         | i<i2 = [n2,i2] : agrupa ((n,i):t)
                         | otherwise = agrupa ((n,i):t)

-}


--3) trocar duas colunas de uma matriz

type Mat a = [[a]]
{-trocaele :: Int -> Int -> [a] -> [a]
trocaele i j xs = let elemI = xs !! i
                            elemJ = xs !! j
                            left = take i xs
                            middle = take (j-i-1) (drop (i+1) xs)
                            right = drop (j+1) xs
                    in  left ++ [elemJ] ++ middle ++ [elemI] ++ right

fun x n [] = []
fun x n (h:t) = (trocaele x n h):(fun x n t)
 -}             

--4) 

data BTree a = Empty | Node a (BTree a) (BTree a) 

replace :: Eq a => BTree a -> a -> a -> BTree a
replace Empty a b = Empty
replace (Node x l r) a b | x==a = (Node b (replace l a b) (replace r a b))
                         | otherwise = (Node x (replace l a b) (replace r a b))

--5)
{-
acrescenta :: Ord a => BTree (a,Int) -> a -> BTree (a,Int)
acrescenta Empty a = Empty
acrescenta (Node (x,n) l r) (cam a) | x==a = (Node x l r)
                                    | cam == esquerda = (Node x (acrescenta l a) r)
                                    | otherwise = (Node l (acrescenta r a))
-}

--6

func :: [(Float,Float)] -> [Float]
func [] = []
func ((h,n):t) = if (h+n)>10 then h : func t else func t


--8

verifica :: [[Char]] -> [String] -> Bool
verifica [[]] [] = True
verifica [[x]] [] = False
verifica [[]] palavra = False
verifica ((h:t)(x:xs):t) |




