module Ficha06 where

--------------------

data BTree a = Empty
             | Node a (BTree a) (BTree a)
          deriving Show
          
--------------------  

arvore1 = (Node 3 (Node 5 (Node 7 Empty Empty) Empty) (Node 6 Empty Empty))

arvore2 = (Node 2 (Node 3 (Node 1 Empty Empty) Empty) Empty)

-------------------- 

--1)

--1.a) calcula a altura da arvore

altura :: BTree a -> Int
altura Empty = 0
altura (Node x l r) = 1 + max (1 + altura l) (1 + altura r)

--1.b) conta os nodos de uma arvore

contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node x l r) = 1 + contaNodos l + contaNodos r

--1.c) calcula o numero de folhas 

folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node _ Empty Empty) = 1
folhas (Node x l r) = folhas l + folhas r

--1.d) remove todos os elementos de uma arvore a partir de uma determinada profundidade

prune :: Int -> BTree a -> BTree a 
prune y Empty = Empty
prune 0 _ = Empty
prune y (Node x l r) = Node x (prune (y-1) l) (prune (y-1) r)

--1.e) dado um caminho (False = esquerda, True = direita) e uma arvore da a lista com infoormaçao dos nodos por onde esse caminho passa

path :: [Bool] -> BTree a ->  [a]
path [] _ = []
path _ Empty = []
path (h:t) (Node x l r) = if h then x : path t l else x : path t r 
 
--1.f) dá a árvore simétrica.

mirror ::BTree a -> BTree a 
mirror Empty = Empty
mirror (Node x l r) = Node x (mirror r) (mirror l)

--1.g) que generaliza a funçao zipWith para árvores binárias.

zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT p _ Empty = Empty
zipWithBT p Empty _ = Empty
zipWithBT p (Node x l r) (Node y z k) = Node (p x y) (zipWithBT p l z) (zipWithBT p r k)

--1.h) generaliza a funçao unzip (neste caso de triplos) para árvores binárias.

unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (x,y,z) l r) = let (l1,l2,l3) = unzipBT l
                                 (r1,r2,r3) = unzipBT r
                             in (Node x l1 r1, Node y l2 r2, Node z l3 r3)

--2

--2.a) calcula o menor elemento de uma árvore binária de procura não vazia

minimo :: Ord a => BTree a -> a
minimo (Node x Empty _) = x
minimo (Node x l r) = minimo l

--2.b) remove o menor elemento de uma árvore binária de procura não vazia

semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node x Empty r) = r
semMinimo (Node x l r) = (Node x (semMinimo l) r) 

--2.c) calcula, com uma unica travessia da árvore o resultado das duas funçoes anteriores.

minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node e Empty _) = (e,Empty)
minSmin (Node e l r) = (a,Node e b r)
    where (a,b) = minSmin l

--2.d) remove um elemento de uma árvore binária de procura, usando a função anterior.

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

--3

type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int | Rep | Faltou
                   deriving Show
type Turma = BTree Aluno -- árvore binária de procura (ordenada por numero)

------------------------

turmaBT = (Node (2, "Rita", MEL, Aprov 15) (Node (3, "Dani", ORD, Faltou) (Node (1, "Diogo", TE, Rep) Empty Empty) Empty) Empty)

------------------------

--3.a) verifica se um aluno, com um dado numero, está inscrito.

inscNum :: Numero -> Turma -> Bool
inscNum x Empty = False
inscNum x (Node (a,b,c,d) l r) = x == a || inscNum x l || inscNum x r

--3.b) verifica se um aluno, com um dado nome, está inscrito.

inscNome :: Nome -> Turma -> Bool
inscNome x Empty = False
inscNome x (Node (a,b,c,d) l r) = x == b || inscNome x l || inscNome x r

--3.c) lista o numero e nome dos alunos trabalhadores-estudantes (ordenados por numero).

trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (a,b,c,d) l r) = case c of TE -> [(a,b)] ++ trabEst l ++ trabEst r 
                                         otherwise -> [] ++ trabEst l ++ trabEst r 

--3.d) calcula a classifiçao de um aluno (se o aluno não estiver inscrito a funçao deve retornar Nothing).

nota :: Numero -> Turma -> Maybe Classificacao
nota x Empty = Nothing
nota x (Node (a,b,c,d) l r) | x == a = Just d 
                            | x < a = nota x l
                            | x > a = nota x r
                            | otherwise = Nothing

--3.e) calcula a percentagem de alunos que faltaram a avaliaçao.

percFaltas :: Turma -> Float
percFaltas Empty = 0
percFaltas turma@(Node (a,b,c,d) l r) = contaFaltas turma /(contaAlunos turma) * 100.0
                                      where
                                        contaFaltas (Node (a,b,c,d) l r) = (case d of Faltou -> 1;otherwise -> 0) + contaFaltas l + contaFaltas r
                                        contaAlunos Empty = 0
                                        contaAlunos (Node x l r) = 1 + contaAlunos l + contaAlunos r

--3.f) calcula a média das notas dos alunos que passaram.

mediaAprov :: Turma -> Float
mediaAprov Empty = 0
mediaAprov turma = sumNotas turma / numNotas turma
                 where sumNotas :: Turma -> Float
                       sumNotas Empty = 0
                       sumNotas (Node (_,_,_,Aprov nota) l r) = fromIntegral nota + sumNotas l + sumNotas r
                       sumNotas (Node e l r) = sumNotas l + sumNotas r
                       numNotas :: Turma -> Float
                       numNotas (Node (_,_,_,clas) l r) = (case clas of Aprov nota -> 1;otherwise -> 0) + numNotas l + numNotas r
                       numNotas _ = 0

--3.g) calcula o rácio de alunos aprovados por avaliados.

aprovAv :: Turma -> Float
aprovAv Empty = 0
aprovAv turma = a / b
    where (a,b) = aux turma
          aux Empty = (0,0)
          aux (Node (_,_,_,clas) l r) = case clas of Aprov nota -> (x+1,y) ; Rep -> (x,y+1) ; otherwise -> (x,y)
            where (x,y) = (c+e,d+f)
                  (c,d) = aux l
                  (e,f) = aux r

--------------------------------------------------------------










