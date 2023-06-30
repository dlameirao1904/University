module Ficha07 where


--1

data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt

--1.a) dada uma destas expressoees calcula o seu valor

calcula :: ExpInt -> Int
calcula (Const n) = n
calcula (Simetrico exp) = (- calcula exp)
calcula (Mais a b) = calcula a + calcula b
calcula (Menos a b) = calcula a - calcula b
calcula (Mult a b) = calcula a * calcula b

--1.b) 

infixa :: ExpInt -> String
infixa (Const num) = show num
infixa (Simetrico exp) = "(-" ++ infixa exp ++ ")"
infixa (Mais a b) = '(':infixa a ++ "+" ++ infixa b ++ ")"
infixa (Menos a b) = '(':infixa a ++ "-" ++ infixa b ++ ")"
infixa (Mult a b) = '(':infixa a ++ "*" ++ infixa b ++ ")"

--1.c) 

posfixa :: ExpInt -> String
posfixa (Const num) = show num ++ ""
posfixa (Simetrico exp) = '-':posfixa exp
posfixa (Mais a b) = posfixa a ++ posfixa b ++ "+"
posfixa (Menos a b) = posfixa a ++ posfixa b ++ "-"
posfixa (Mult a b) = posfixa a ++ posfixa b ++ "*" 

--2

data RTree a = R a [RTree a]



--2.a) soma os elementos da arvore

soma :: Num a => RTree a -> a
soma (R e []) = 0
soma (R e l) = e + sum (map (soma) l)

--2.b) calcula a altura da arvore.

altura :: RTree a -> Int
altura (R e []) = 0
altura (R e l) = 1 + maximum (map (altura) l)

--2.c) remove de uma arvore todos os elementos a partir de uma determinada profundidade.

prune :: Int -> RTree a -> RTree a
prune a (R e []) = R e []
prune a (R e l ) = R e (map(prune (a-1)) l)

--2.d) gera a arvore simetrica.

mirror :: RTree a -> RTree a
mirror (R e l) = R e (map mirror (reverse l))

--2.e) travessia postorder da arvore.

postorder :: RTree a -> [a]
postorder (R e []) = [e]
postorder (R e l) =concatMap postorder l ++ [e]

--3

data BTree a = Empty | Node a (BTree a) (BTree a)
data LTree a = Tip a | Fork (LTree a) (LTree a) 

arvore1 = Fork (Fork (Tip 7) (Tip 1)) (Tip 2)

--3.a) soma as folhas de uma arvore.

ltSum :: Num a => LTree a -> a
ltSum (Tip a) = a
ltSum (Fork a b) = ltSum a + ltSum b

--3.b)  lista as folhas de uma arvore (da esquerda para a direita).

listaLT :: LTree a -> [a]
listaLT (Tip a) = [a]
listaLT (Fork a b) = listaLT a ++ listaLT b

--3.c) calcula a altura de uma arvore.

ltHeight :: LTree a -> Int
ltHeight (Tip a) = 0
ltHeight (Fork a b) = 1 + (max (1 + ltHeight a) (1 + ltHeight b))

--4

data FTree a b = Leaf b | No a (FTree a b) (FTree a b)

--4.a) separa uma arvore com informaçao nos nodos e nas folhas em duas arvores de tipos diferentes.

splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree (Leaf a) = (Empty, Tip a)
splitFTree (No a b c) = (Node a (fst (splitFTree b)) (fst (splitFTree c)), Fork (snd (splitFTree b)) (snd (splitFTree c))) 

--4.b) junta listas compativeis

joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees (Empty) (Tip n) = Just (Leaf n)
joinTrees (Node e l r) (Fork a b) = Just (No e aux aux2)
    where Just aux = joinTrees l a
          Just aux2 = joinTrees r b
joinTrees _ _ = Nothing  

----------------------------------------


                                      





                                    








