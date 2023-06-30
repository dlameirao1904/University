
module Ficha2 where
import Data.Char (ord)
import Data.List (partition)

--1) indicar como as funçoes sao compiladas

--1.a) 

funA :: [Double] -> Double
funA [] = 0
funA (h:t) = h^2 + (funA t)

--  funA [2,3,5,1] = funA (2:[3,5,1]) = 2^2 + funA [3,5,1] =
--  = 4 + funA (3:[5,1]) = 4 + 3^2 + funA [5,1] = 13 + funA (5:[1]) =
--  = 13 + 5^2 + funA [1] =  38 + funA (1:[]) = 38 + 1^2 + funA [] = 39 + 0 = 39

--1.b) 

funB :: [Int] -> [Int]
funB [] = []
funB (h:t) = if (mod h 2)==0 then h : (funB t) else (funB t)

--  funB [8,5,12] = funB (8:[5,12]) = 8:funB [5,12] = 8:funB (5:[12]) =
--  = 8:funB [12] = 8:funB (12:[]) = 8:12:funB [] = 8:12:[] = [8,12]

--1.C) 

funC (x:y:t) =funC t
funC [x] = []
funC [] = []

--  funC [1,2,3,4,5] = funC (1:2:[3,4,5]) = funC [3,4,5] = funC (3:4:[5]) =
--  = funC [5] = []

-- 1.d)

funD l = g [] l
g l [] = l
g l (h:t) = g (h:l) t

--  funD "otrec" = g [] "otrec" = g [] 'o':"trec" = g 'o':[] "trec" = g ['o'] 't':"rec" =
--  = g 't':['o'] "rec" = g "to" 'r':"ec" = g 'r':"to" "ec" = g "rto" 'e':['c'] =
--  = g 'e':"rto" ['c'] = g "erto" 'c':[] = g 'c':"erto" [] = "certo"

--2

--2.a) recursiva que recebe uma lista de elementos e responde com uma lista do dobro desses elementos

dobros :: [Float] -> [Float]
dobros [] = []
dobros (h:t) = 2*h : (dobros t)

--2.b) recursiva que calcula o numero de vezes que um caracter ocorre numa string

numOcorre :: Char -> String -> Int
numOcorre _ [] = 0
numOcorre x (h:t) = if x==h then 1 + numOcorre x t else numOcorre x t

--2.c) recursiva que testa se os elementos de uma lista sao positivos

positivos :: [Int] -> Bool
positivos [] = False
positivos [x] = if x>=0 then True else False
positivos (h:t) | h < 0     = False
                | otherwise = positivos t

--2.c) recursiva que retira todos os elementos negativos de uma lista

soPos :: [Int] -> [Int]
soPos [] = []
soPos [x] | x < 0     = []
          | otherwise = [x]
soPos (h:t) | h < 0     = soPos t
            | otherwise = h : soPos t

--2.e) recursiva que soma todos os elementos negativos de uma lista

somaNeg :: [Int] -> Int
somaNeg [] = 0
somaNeg [x] = if x < 0 then x else 0
somaNeg (h:t) = if h < 0 then h + somaNeg t else somaNeg t 

--2.f) recursiva que devolve os ultimos 3 elementos de uma lista. se a lista de entradativer menos de 3 elementos devolve a propria lista

tresUlt :: [a] -> [a]
tresUlt l = case l of (_:b:c:d:xs) -> (c:d:xs)
                      _ -> l

--2.g) recursiva que calcula a lista dos segundos elementos dos pares

segundos :: [(a,b)] -> [b]
segundos [] = []
segundos [(a,b)] = [b]
segundos ((h,s):t) = [s] ++ segundos t

--2.h) recursiva que testa se um elemento aparece na lista como primeiro elemento de alguns pares

nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros _ [] = False
nosPrimeiros a [(b,c)] = if a==b then True else False
nosPrimeiros a ((h,s):t) = if a==h then True else nosPrimeiros a t

--2.i) recursiva que soma uma lista de triplos,componente a componente

sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos [] = (0,0,0)
sumTriplos [(a,b,c)] = (a,b,c)
sumTriplos ((a,b,c):(d,e,f):t) = ((a+d+sX),(b+e+sY),(c+f+sZ))
                               where
                                (sX,sY,sZ) = sumTriplos t

--3

--3.a) recursiva que recebe uma lista de caracteres e devolve uma lista de caracteres cujos sao somente algarismos

soDigitos :: [Char] -> [Char]
soDigitos [] = []
soDigitos (h:t) | h `elem` ['0'..'9'] = h:soDigitos t
                | otherwise           = soDigitos t

--3.b) recebe uma lista de caracteres e conta quantas letras minusculas tem nessa lista

minusculas :: [Char] -> Int
minusculas [] = 0
minusculas (h:t) = if h `elem` ['a'..'z'] then 1 + minusculas t else minusculas t

--3.c) recursiva que recebe uma string e devolve uma lista com os algarismos que ocorrem na string, pela mesma ordem

nums :: String -> [Int]
nums [] = []
nums (c:str) = if c `elem` ['0'..'9'] then (ord c - ord '0') : nums str
                                      else nums str

--4

type Polinomio = [Monomio]
type Monomio = (Float,Int)

--4.a) funçao tal que (conta n p) indica quantos monomios de grau n existem em p

conta :: Int -> Polinomio -> Int
conta _ [] = 0
conta n ((_,e):t) = if e == n then 1 + conta n t else conta n t 

--4.b) indica o grau de um polinomio

grau :: Polinomio -> Int
grau [] = 0
grau [(b,e)] = e
grau ((b,e):t) = if e > grau t then e else grau t 

--4.c) seleciona os monomios com um dado grau de um polinomio

selgrau :: Int -> Polinomio -> Polinomio
selgrau _ [] = []
selgrau x ((b,e):t) = if x == e then (b,e) : selgrau x t else selgrau x t

--4.d) calcula a derivada um polinomio

deriv :: Polinomio -> Polinomio
deriv [] = []
deriv ((b,e):t) = if e == 0 then (0,0) : deriv t else (b * (fromIntegral e), e - 1) : deriv t  

--4.e) calcula um polinomio que um determinado valor de x

calcula :: Float -> Polinomio -> Float
calcula _ [] = 0
calcula x ((b,e):t) = b * (x^e) + calcula x t

--4.f) retira de um polinomio os monomios de expoente 0

simp :: Polinomio -> Polinomio
simp [(b,e)] = if e < 1 then [] else [(b,e)]
simp ((b,e):ps) = if e < 1 then simp ps else (b,e):simp ps

--4.g) calcula a multiplicaçao de um monomio com um polinomio

mult :: Monomio -> Polinomio -> Polinomio
mult _ [] = []
mult (b,e) ((m,n):t) = (b*m,e+n) : mult (b,e) t

--4.h) dado um polinomio  constroi um polinomio equivalente em que nao podem aparecer podem varios monomios com o mesmo grau

normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza [(b,e)] = [(b,e)]
normaliza ((b,e):(bk,ek):ps) | e==ek           = normaliza ((b+bk,e):ps)
                             | conta e ps == 0 = (b,e) : normaliza ((bk,ek):ps)
                             |otherwise        = normaliza ((b,e) : ps ++ [(bk,ek)])

--4.i) faz a soma de dois polinomios de forma que se os polinomiosque recebe estiverem normalizados produz tambem um polinomio normalizado

soma :: Polinomio -> Polinomio -> Polinomio
soma p1 p2 = normaliza (p1 ++ p2) 

--4.j) calcula o produto de dois polinomios

produto :: Polinomio -> Polinomio -> Polinomio
produto [] _ = []
produto (p:p1) p2 = soma (mult p p2) (produto p1 p2)

--4.k) orrdena os polinomios crescente dos graus dos seus monomios 

ordena :: Polinomio -> Polinomio
ordena [] = []
ordena ((b,e):ps) = ordena (maiores ps) ++ [(b,e)] ++ ordena (menores ps)
    where maiores [] = []
          maiores ((bx,ex):xs) = if ex > e || (ex == e && bx >= b) then (bx,ex):maiores xs else maiores xs
          menores [] = []
          menores ((bx,ex):xs) = if ex < e || (ex == e && bx < b) then (bx,ex):menores xs else menores xs

--4.l)testa se dois polinomios sao equivalentes

equiv :: Polinomio -> Polinomio -> Bool
equiv p1 p2 = ordena (normaliza p1) == ordena (normaliza p2)

--------------------------------------------------------------------------------------------------------------------------------






