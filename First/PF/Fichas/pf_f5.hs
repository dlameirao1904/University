module Ficha05 where
import Data.List

--1.a) testa se um predicado é verdade para algum elemento de uma lista; por exemplo:
--any odd [1..10] == True

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (h:t) = if p h then True else any' p t

--1.b)  combina os elementos de duas listas usando uma funçao especifica; por exemplo:
--zipWith (+) [1,2,3,4,5] [10,20,30,40] == [11,22,33,44]

zipWith' ::  (a->b->c) -> [a] -> [b] -> [c]
zipWith' p [] _ = []
zipWith' p _ [] = []
zipWith' p (h:t) (x:xs) = (p h x):(zipWith' p t xs)

--1.c) determina os primeiros elementos da lista que satisfazem um dado predicado; por exemplo:
--takeWhile odd [1,3,4,5,6,6] == [1,3].

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' p (h:t) | p h       = h:takeWhile' p t
                   | otherwise = []

--1.d) elimina os primeiros elementos da lista que satisfazem um dado predicado; por exemplo:
--dropWhile odd [1,3,4,5,6,6] == [4,5,6,6]

dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' p [] = []
dropWhile' p (h:t) = if p h then dropWhile' p t else t

--1.e) calcula simultaneamente os dois resultados anteriores

span' :: (a-> Bool) -> [a] -> ([a],[a])
span' p [] = ([],[])
span' p (h:t) = if p h then (h:x,y) else ([],(h:t))
              where
                (x,y) = span' p t 

--1.f) apaga o primeiro elemento de uma lista que é “igual” a um dado elemento de acordo com a funçao de comparaçao que é passada como parâmetro. Por exemplo:
--deleteBy (\x y -> snd x == snd y) (1,2) [(3,3),(2,2),(4,2)]

deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a] 
deleteBy' p x [] = []
deleteBy' p x (h:t) = if p x h then t else h:deleteBy' p x t

--1.g) ordena uma lista comparando os resultados de aplicar uma funçao de extraçao de uma chave a cada elemento de uma lista. Por exemplo:
--sortOn fst [(3,1),(1,2),(2,5)] == [(1,2),(2,5),(3,1)]

--sortOn' :: Ord b => (a -> b) -> [a] -> [a]
--sortOn' p [] = []
--sortOn' p (h:t) = insere (h) (sortOn' f t)
--            where 
--                insere x [] = [x]
--                insere x (a:b) = if f x > f a then a:insere x b else x:a:b

--2) relembrar polinomios da ficha 3

--------------------------

type Monomio = (Float,Int)
type Polinomio = [Monomio]

-- ------------------------
--2.a) seleciona um monomio com um determinado grau

selgrau :: Int -> Polinomio -> Polinomio
selgrau n f = filter (\x -> snd x == n) f

--2.b) indica quantos monómios de grau n existem em p.

conta :: Int -> Polinomio -> Int
conta n p = length $ filter (\x -> snd x == n) p

--2.c) indica o grau de um polinómio.

grau :: Polinomio -> Int
grau p = foldr (\(c,e) r -> max e r) 0 p 

--2.d) calcula a derivada de um polinomio

deriv :: Polinomio -> Polinomio
deriv p = map (\(c,e) -> (c * fromIntegral (e),e-1)) p

--2.e) calcula o valor do polinomio paraum determinado valor de x

calcula :: Float -> Polinomio -> Float
calcula n p = sum $ map(\(c,e) -> c * n^e) p 

--2.f) retira do polinomio os monomios de coeficiente 0

simp :: Polinomio -> Polinomio
simp p = filter (\(c,e) -> c /= 0) p 

--2.g) multiplicaçao de um monimomio por um polinomio

mult :: Monomio -> Polinomio -> Polinomio
mult (x,k) p = map (\(c,e) -> (c*x,e+k)) p

--2.h) ordena um polinomo pelos seus monomios por ordem crescente 

ordena :: Polinomio -> Polinomio
ordena [] = []
ordena (x@(_,b):xs) = let m1 = filter ((< b) . snd) xs
                          m2 = filter ((>= b) . snd) xs
                      in (ordena m1) ++ [x] ++ (ordena m2)    

--2.i) polinómio constrói um polinómio equivalente em que não podem aparecer varios monómios com o mesmo grau.

normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza ((b,e):ps) = (sum [bs | (bs,es) <- selgrau e ps] + b,e):normaliza [(bo,eo) | (bo,eo) <- ps, eo /= e]

--2.j) soma de dois polinomios de forma a se por ventura receber normalizados responde com normalizados tambem

soma :: Polinomio -> Polinomio -> Polinomio
soma p l = normaliza $ (++) p l

--2.k) calcula o produto de dois polinomios

produto :: Polinomio -> Polinomio -> Polinomio
produto [] [] = []
produto [] l = []
produto l [] = []
produto ((x,k):t) l = normaliza $ mult (x,k) l ++ produto t l

--2.l) testa se dois polinomios sao equivalentes 

equiv :: Polinomio -> Polinomio -> Bool
equiv l [] = False
equiv [] l = False
equiv p l = normaliza p == normaliza l

--3

-------------------

type Mat a = [[a]]

-------------------

--3.a) testa se uma matriz esta bem construida

dimOk :: Mat a -> Bool
dimOk [[]] = True
--dimOk [(h:t),(x:xs)] = if length (h:t) == length (x:xs) then True else False
dimOk (h:t) = length h == length t 

-- 3.b) calcula a dimensão de uma matriz

dimMat :: Mat a -> (Int,Int)
dimMat lista@(h:t) = (length lista, length h) -- assumindo que a matriz dada está bem construida
--caso seja necessario verificar se a matriz está bem construida                  if dimOk lista == True then (length lista, length h) else (0,0)

--3.c) Adiciona duas matrizes

addMat :: Num a => Mat a -> Mat a -> Mat a -- têm de ter as mesmas dimensoes
addMat l1 l2 = zipWith somaListas l1 l2
             where
                somaListas l1 l2 = zipWith (+) l1 l2

--3.d) calcula a matriz transposta
transpose' :: Mat a -> Mat a 
transpose' [] = []
transpose' (h:t) = (map head (h:t)) : transpose' (map tail (h:t)) 

--3.e) calcula o produto de duas matizes

multMat :: Num a => Mat a -> Mat a -> Mat a
multMat [] _ = []
multMat (h:t) b = [ multlines h y | y <- list ] : multMat t b
                where 
                    list = transpose' b
                    multlines x y = sum $ zipWith (*) x y

--3.f) combina duas matrizes
{-
zipWMat :: (a -> b -> c) -> Mat a -> Mat b -> Mat c
zipWMat _ [] [] = []
zipWMat f (h:t) (x:xs) = zipWith f h x : zipWith f t xs


--3.g) testa se uma matriz é triangular superior

triSup :: Num a => Mat a -> Bool
triSup [] = False
triSup mat = (all (==0) . concat . filterZeros) mat
           where
            filterZeros [[x]] = []
            filterZeros mat = tail x : (filterZeros . transpose) (map tail xs)
                            where 
                                (x:xs) = transpose mat
-}

--3.g) roda a matriz 90º para a esquerda 

rotateLeft :: Mat a -> Mat a
rotateLeft mat = (reverse . transpose) mat

-------------------------------------------------------------------------



    

