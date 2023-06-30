module Teste2020_21 where


import Data.List


--1)
{-
doisbarra :: Eq a => [a] -> [a] -> [a]
doisbarra [] _ = []
doisbarra l [] = l
doisbarra l (h:t) = doisbarra (mydelete h l) t

mydelete :: Eq a => a -> [a] -> [a]
mydelete _ [] = []
mydelete x (h:t) = if x==h then t else h : mydelete x t
-}

remove_l :: Eq a => [a] -> [a] -> [a]
remove_l l [] = []
remove_l [] l = []
remove_l l (h:t) = remove_l (mydelete h l) t

mydelete :: Eq a => a -> [a] -> [a]
mydelete _ [] = []
mydelete n (x:xs) | n == x = xs
                  | otherwise = x:mydelete n xs  

--2.a)

removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet x ((y,n):ys) | x==y && n>1  = (y,n-1) : ys
                        | x==y && n==1 = ys
                        | otherwise    = (y,n) : removeMSet x ys 

--2.b) 

type Mset a = [(a,Int)]

calcula :: Mset a -> ([a],Int)
calcula l = foldl (\(acc1,acc2) (a,b) -> (a:acc1 , b+acc2)) ([],0) l            

--3)

partes ::String-> Char -> [String]
partes "" _ =  [""]
partes l@(h:t) x  = if (x==h) then partes t x 
                    else acumulador l x " "

acumulador :: String -> Char -> String  -> [String]
acumulador "" _ _ = [""]
acumulador (h:t) b acc = if (h == b) then [acc]++ acumulador t b [] 
                         else acumulador t b (acc++ [h])


partes' :: String -> Char -> [String]
partes' [] c = []
partes' l c = words (aux l c)
            where
                aux [] c = []
                aux (h:t) c | h == c = [' '] ++ aux t c
                            | otherwise = h : aux t c

--4.a) 

data BTree a = Empty
             | Node a (BTree a) (BTree a)
         -- deriving Show

arvore1 = (Node 3 (Node 5 (Node 7 Empty Empty) Empty) (Node 6 Empty Empty))

remove :: Ord a => a -> BTree a -> BTree a
remove _ Empty = Empty
remove n (Node x l r) | x < n     = Node x (remove n l) r
                      | x > n     = Node x l (remove x r)
                      | otherwise = aux n (Node x l r)
                                  where
                                    aux n (Node a b c) = case b of Empty -> c
                                                                   otherwise -> case c of Empty -> b
                                                                                          otherwise -> (Node g b h)
                                                       where
                                                        (g,h) = minSmin r

minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node e Empty _) = (e,Empty)
minSmin (Node e l r) = (a,Node e b r)
    where (a,b) = minSmin l


remove' :: Ord a => a -> BTree a -> BTree a
remove' n Empty = Empty
remove' n (Node x l r) | x < n     =  Node  x  (remove n l) r
                                         | x > n     =  Node x  l  (remove x r)
                                         | otherwise =  Empty

--4.b)

instance Show a => Show (BTree a) where
    show (Node x l r) = aux (Node x l r)
                      where
                        aux :: Show a => BTree a -> String
                        aux Empty = "*"
                        aux (Node x l r) = "(" ++ aux l ++ "<-" ++ show x ++ "->" ++ aux r ++ ")"

--5) definir a sortOn

sortOn ::Ord b => (a->b)-> [a]-> [a]
sortOn _ [] = []
sortOn f (h:t) = insert' h (sortOn f t)
    where insert' a [] = [a]
          insert' a (x:y) = if f a > f x then x:insert' a y else a: x :y
--6

data FyleSystes = File Nome | Dir Nome [FileSystem]
type Nome = String

fs1 = Dir "usr" [Dir "xxx" [File "abc.txt", File "readme", Dir "PF" [File "exemplo.hs"]], Dir "yyy" [], Dir "zzz" [Dir "tmp" [], File "teste.c"]

--a)
{-
fichs :: FileSystem -> [Nome]
fichs [] = []
fichs x = if x==(File n) then [x]
          else if x==(Dir n l) then junta(map fichs l)
        where
            junta :: [a] -> [a] -> [a]
            junta [] [] = []
            junta [] l = l
            junta (h:t) l = h:junta t l
-}




















