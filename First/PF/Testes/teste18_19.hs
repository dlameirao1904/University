module Teste18_19 where

--1

--1.a) e calcula a lista de posiçoes em que um elemento ocorre numa lista.

elemIndices :: Eq a => a -> [a] -> [Int]
elemIndices x [] = []
elemIndices x l = aux 0 x l 
                where 
                  aux _ _ [] = []
                  aux i x (h:t) | x==h = i:aux (i+1) x t
                                | otherwise = aux (i+1) x t

--1.b) testa se os elementos de uma lista ocorrem noutra pela mesma ordem relativa

isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf (a:b) (c:d) | a == c = isSubsequenceOf b d
                            | otherwise = isSubsequenceOf (a:b) d

--2

data BTree a = Empty | Node a (BTree a) (BTree a)

--2.a) generaliza funçao lookup para arvores binarias de procura. 

lookupAP :: Ord a => a -> BTree (a,b) -> Maybe b
lookupAP x Empty = Nothing
lookupAP x (Node  (a,b) l r) | x == a = Just b
                             | x < a = lookupAP x l
                             | otherwise = lookupAP x r

--2.b) generaliza a funÇao zipWith para Arvores binarias.

zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c 
zipWithBT p _ Empty = Empty
zipWithBT p Empty _ = Empty
zipWithBT p (Node a b c) (Node x y z) = (Node (p a x) (zipWithBT p b y) (zipWithBT p c z))

--3) dada uma string, devolve um par de strings: uma apenas com os numeros presentes nessa string, e a outra apenas com as letras presentes na string. Implemente a funçao de modo a fazer uma unica travessia da string.

digitAlpha :: String -> (String,String)
digitAlpha = foldr (\x (ds,as) -> if isDigit x then (x:ds,as) else if isAlpha x then (ds,x:as) else (ds,as)) ([],[]) 

--4) 

data Seq a = Nil | Cons a (Seq a) | App (Seq a) (Seq a)

--4.a) recebe uma sequencia nao vazia e devolve o seu primeiro elemento.

firstSeq :: Seq a -> a
firstSeq (Cons a s) = a
firstSeq (App Nil s) = firstSeq s
firstSeq (App s _) = firstSeq s

--4.b) elimina os n primeiros elementos da sequencia s

dropSeq :: Int -> Seq a -> Seq a
dropSeq _ Nil = Nil
dropSeq n (Cons a s) = dropSeq (n-1) s
dropSeq n (App s1 s2) | n > nx = dropSeq (n - nx) s2
                      | n == nx = s2
                      | otherwise = (App (dropSeq n s1) s2)
    where nx = contaCons s1

contaCons :: Seq a -> Int
contaCons Nil = 0
contaCons (Cons _ s) = 1 + contaCons s
contaCons (App s1 s2) = contaCons s1 + contaCons s2


