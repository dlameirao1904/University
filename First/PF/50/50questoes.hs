

--50 questoes pf

--1-- funçao recursiva enumFromto, que constroi uma lista de elementos (inteiros) entre dois limites. Ex: dado enumFromto 1 5 = [1,2,3,4,5].

enumFromto :: Int -> Int -> [Int]
enumFromto x y = if x == y then [y] else x : enumFromto (x+1) y

--2-- funçao recursiva da funçao (pre-definida) enumFromThenTo ::  Int -> Int-> Int -> [Int]que constroi a lista dos numeros inteiros entre dois limitese espacados de um valor constante.Ex. enumFromThenTo 1 3 10 = [1,3,5,7,9].

myenumFromThenTo :: Int -> Int -> Int -> [Int]
myenumFromThenTo a k b | a<k && a<b = a:myenumFromThenTo k (k+(k-a)) b
                     | a==b       = [a] 
                     | a==k       = repeat a
                     | otherwise  = []

--3-- funçao que junta 2 listas

junta :: [Int] -> [Int] -> [Int]
junta [] [] = []
junta [] l = l
junta (h:t) l = h:junta t l

--4-- (!!) funçao que dado um n calcula a posiçao correspondente ao elemento da lista (o primeiro elemento da lista corresponde a posiçao 0)

pelementos :: [a] -> Int -> a
pelementos (h:t) n = if n==0 then h else pelementos t (n-1)

--5-- funçao que reverte/inverte os elementos de uma lista

inversa :: [Int] -> [Int]
inversa [] = []
inversa (h:t) = inversa t ++ [h] --usei a funçao predefinida em haskell de junçao de listas (++), mas podia usar a funçao anteriormente definida «junta»

--6--funçao que calcula, dado um n e uma lista, os n maximos elementos dessa mesma lista

take' :: Int -> [a] -> [a]
take' n [] = []
take' 0 _ = []
take' n (h:t) = [h] ++ take' (n-1) t

--7-- funçao recursiva que dado um n e uma lista responde com uma lista sem os n maximos dela

drop' :: Int -> [a] -> [a]
drop' n [] = []
drop' 0 l = l
drop' n (x:xs) = drop' (n-1) xs

--8-- fuçao recursiva que constroi uma lista de pares atraves  de duas listas

zip' :: [a] -> [b] -> [(a,b)]
zip' [] [] = []
zip' [] l = []
zip' (h:t) (x:xs) = (h,x):zip' t xs

--9--funçao recuriva que testa se um elemento pertence ou nao a uma lista

elem' :: Eq a => a -> [a] -> Bool
elem' n [] = False
elem' n (h:t) = n==h||elem' n t

--10-- funçao recursiva  que dado um inteiro n e um elemento x constroi uma lista com o mesmo x, n vezes

replicate' :: Int -> a ->[a]
replicate' 0 _ = []
replicate' n x = x:replicate' (n-1) x

--11--funçao recursiva que dado um elemento e uma lista, constroi uma lista em que o elemnto fornecido  é fornecido é intercalado entre os elemntos da lista fornecida

intersperce' :: Int -> [Int] -> [Int]
intersperce' n [] = []
intersperce' n [x] =[x]
intersperce' n (h:t) = h : n : intersperce' n t

--12--funçao recursiva que agupa elemntos iguais e consecutivos de uma lista

doze :: Eq a => [a] -> [[a]]
doze [] = []
doze [x] =[[x]] 
doze (x:y:z) = if x == y then [x,y]:doze z
               else [x]:doze(y:z) 

--13-- funçao recursiva que concatena as listas de uma lista

myconcatena :: [[a]] -> [a]
myconcatena [[]] = []
myconcatena (h:t) = h  ++ myconcatena t

--14-- funçao recursiva que calcula os prefixos de uma lista -- soluçoes da dropbox e jbb

myinits :: [a] -> [[a]]
myinits [] = []
myinits l = myinits (init l) ++ [l]

--15--funçao recursiva que calcula os sufixos de uma lista -- soluçoes dropbox e jbb

mytails :: [a] -> [[a]]
mytails [] = [[]]
mytails l = [l] ++ mytails (tail l)

--16-- funçao recursiva que testa se uma lista é prefixa de outra

myprefixof :: Eq a => [a] -> [a] -> Bool
myprefixof [] l = True
myprefixof l [] = False
myprefixof (h:t) (x:xs) | h==x && myprefixof t xs = True
                        | otherwise               = False 

--17-- funçao recursiva que testa se uma lista é sufixa de outra

mysufixof :: Eq a => [a] -> [a] -> Bool
mysufixof [] l = True
mysufixof l [] = False
mysufixof (h:t) (x:xs) = (h:t)==(x:xs) || mysufixof (h:t) xs

--18-- funçao recursiva que testa se os elementos de uma lista ocorrem na ordem certa

issequenceof :: Eq a => [a] -> [a] -> Bool
issequenceof [] l = True
issequenceof l [] = False
issequenceof (h:t) (x:xs) = h==x && issequenceof t xs || issequenceof (h:t) xs

--19-- funçao recursiva que calcula as posiçoes em que um elemento de uma lista ocorre

myelemIndicess :: Eq a => a -> [a] -> [Int]
myelemIndicess x [] = []
myelemIndicess x l = aux 0 x l
                   where 
                    aux _ _ [] = []
                    aux i x (h:t) | x==h      = i:aux (i+1) x t
                                  | otherwise = aux (i+1) x t

--20-- funçao recursiva que calcula uma lista com os mesmos elementos da recebida, sem repetiçoes

mynub :: Eq a => [a] -> [a]
mynub [] = []
mynub (h:t) = h : mynub (aux h t)
            where
                aux _ [] = []
                aux x (y:ys) = if x==y then aux x ys else y:aux x ys

--21-- funçao recursia que retorna a lista resultante de remover (na primeira ocorrencia) um dado elemento de uma lista

mydelete :: Eq a => a -> [a] -> [a]
mydelete _ [] = []
mydelete x (h:t) = if x==h then t else h : mydelete x t

--22-- funçao recursiva que retorna a lista resultante de remover (nas primeiras ocorrencias) dos elementos da segunda lista da primeira

doisbarra :: Eq a => [a] -> [a] -> [a]
doisbarra [] _ = []
doisbarra l [] = l
doisbarra l (h:t) = doisbarra (mydelete h l) t
 

--23--funçao recursiva que retorna a lista resultante de acrescentar à primeira lista os elementos da segunda lista que nao ocorrem

myunion :: Eq a => [a] -> [a] -> [a]
myunion [] l = l
myunion l [] = l
myunion l (x:xs) | elem x l  = myunion l xs
                 | otherwise = myunion (l ++ [x]) xs

--24-- funçao recursiva que retorna a lista resultante de remover da 1ª lista os elementos que nao pertencem a 2ª lista

myintersect :: Eq a => [a] -> [a] -> [a]
myintersect [] l = []
myintersect l [] = []
myintersect (x:xs ) l | elem x l    = x : myintersect xs l
                      | otherwise   = myintersect l xs

--25-- funçao recursiva que dado um elemento e uma lista retorna essa lista com o elemnto inserido ordenadamente

myinsert :: Ord a => a -> [a] -> [a]
myinsert x [] = [x]
myinsert x (h:t) | x <= h = x : h : t
                 | x>h    = h : myinsert x t

--26-- funçao recursiva que justa as strings de uma lista so separadas por um espaçao

myunwords :: [String] -> String
myunwords []    = ""
myunwords [x]   = x
myunwords (h:t) = h++[' ']++myunwords t 

--27-- funçao recursiva que junta as strings de uma lista so separadas apenas por \n

myunlines :: [String] -> String
myunlines [] = ""
myunlines [x] = x ++ "\n"
myunlines (h:t) = h ++ "\n" ++ myunlines t

--28-- funçao recursiva que dada uma lista nao vazia,retorna a posiçao onde se encontra o maior elemento da lista

pMaior :: Ord a => [a] -> Int
pMaior [x] = 0
pMaior (h:t) | h == aux (h:t) = 0
             | otherwise      = 1 + pMaior t
            where
                aux [x] = x
                aux (x:y:t) | x>=y      = aux (x:t)
                            | otherwise = aux (y:t)

--29-- funçao recursiva que testa se uma lista tem repetidos

temRepetidos :: Eq a => [a] -> Bool
temRepetidos [] = False
temRepetidos [x] = False
temRepetidos (h:t) | elem h t = True
                   | otherwise = temRepetidos t

--30-- funçao recursiva que dada uma lista de caracteres determina a lista de algarismos dos elementos numericos da lista de caracteres

algarismos :: [Char] -> [Char]
algarismos [] = []
algarismos (h:t) | h >= '0' && h <= '9' = h : algarismos t
                 | otherwise        = algarismos t

--31-- funçao recursiva que determina a posiçao dos elementos de uma lista que ocorrem em posiçoes impares.

posImpares :: [a] -> [a]
posImpares [] = []
posImpares l = aux False l
             where
               aux _ [] = []
               aux True  (h:t) = h:aux False t
               aux False (h:t) = aux True t

--32-- funçao recursiva que determina a posiçao dos elementos de uma lista que ocorrem em posiçoes pares

posPares :: [a] -> [a]
posPares [] = []
posPares l = aux True l
           where
            aux _ [] = []
            aux True  (h:t) = h:aux False t
            aux False (h:t) = aux True t

--33-- funçao recursiva que testa se uma lista esta ordenada por ordem crescente

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (h:x:t) | h>x       = False
                 | otherwise = isSorted (x:t) 

--34-- funçao recursiva que calcula o resultado de ordenar uma lista 

iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort (h:t) = myinsert h (iSort t)

--35-- funçao recursiva que dada duas strings, retorna True se e só se a primeira for menor que a segunda

menor :: String -> String -> Bool
menor [] [] = False
menor _ [] = False
menor [] _ = True 
menor (h:t) (x:xs) | h == x    = menor t xs
                   | h > x     = False
                   | otherwise = True
 
--36-- funçao recursiva que testa se um elemento pertence a um multi-conjunto

myelemMSet :: Eq a => a -> [(a,Int)] -> Bool
myelemMSet x [] = False
myelemMSet x ((y,n):ys) | x==y      = True
                        | otherwise = myelemMSet x ys 

--37-- funçao recursiva que calcula o tamanho de um multiconjunto

lengthMSet :: [(Char,Int)] -> Int
lengthMSet [] = 0
lengthMSet ((y,n):t) = n + lengthMSet t 

--38-- funçao recursiva que dado um multi-conjunto converte esse multi-conjunto na lista dos seus elementos

converteMSet :: [(a,Int)] -> [a]
converteMSet [] = []
converteMSet ((y,n):ys) = aux (y,n) ++ converteMSet ys
                       where
                         aux (y,0) = []
                         aux (y,n) = [y] ++ aux (y,n-1)

--39-- funçao que insere um elemento a um multi-conjunto

insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet x [] = [(x,1)] 
insereMSet x ((y,n):ys) | x == y    = ((y,n+1):ys) 
                        | otherwise = (y,n) : insereMSet x ys

--40-- funçao que remove um elemento dum multi-conjunto

removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet x ((y,n):ys) | x==y && n>1  = (y,n-1) : ys
                        | x==y && n==1 = ys
                        | otherwise    = (y,n) : removeMSet x ys

--41-- funçao que dada uma lista ordenada por ordem crescente calcula o multi-conjunto dos seus elementos

{-constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet l = aux 1 l
               where
                aux i [x] = [(x,i)]
                aux i (x:y:xs) | x==y = aux (i+1) (x:xs)
                               | x/=y = (x,i):aux 1 (y:xs)-}

constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet [] = []
constroiMSet [x] = [(x,1)]
constroiMSet (h:t) = reverse $ insereMSet h (constroiMSet t)

--42-- funçao recursiva  que divide a lista de Eithers em duas listas (nao percebi o que é uma lista de Eithers)

mypartitionEithers :: [Either a b] -> ([a],[b])
mypartitionEithers l = (left l,right l)
                    where
                      left [] = []
                      left  ((Left a):t)   = a : left t
                      left t  = (Left t) 
                      right [] = []
                      right ((Right a):t)   = right t
                      right t = []

--43-- funçao recursiva que coleciona os elementos do tipo a de uma Lista 

mycatMaybes :: [Maybe a] -> [a]
mycatMaybes [] = []
mycatMaybes (Just a : t) = a : mycatMaybes t
mycatMaybes (Nothing : t) = mycatMaybes t

--

data Movimento = Norte | Sul | Este | Oeste
               deriving Show

--

--44-- funçao que dada uma posiçao inicial (coordenadas) e uma sequencia de movimentos calcula a posiçao final do robot

posicao ::  (Int,Int) -> [Movimento] -> (Int,Int)
posicao (x,y) [] = (x,y)
posicao (x,y) (Norte:t) = posicao (x,y+1) t
posicao (x,y) (Sul:t)   = posicao (x,y-1) t
posicao (x,y) (Este:t)  = posicao (x+1,y) t
posicao (x,y) (Oeste:t) = posicao (x-1,y) t


--45-- funçao que dada a posiçao incial e final calcule a lista de movimentos 

caminho :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (x0,y0) (x1,y1) | x0==x1 && y0==y1 = []
                        | y0>y1 = Sul : caminho (x0,y0) (x1,y1+1)
                        | y0<y1 = Norte : caminho (x0,y0) (x1,y1-1)
                        | x0>x1 = Oeste : caminho (x0,y0) (x1+1,y1)
                        | x0<x1 = Este : caminho (x0,y0) (x1-1,y1)

--46-- dunçao que verifica se o movimento do robot é so vertica

vertical :: [Movimento] -> Bool
vertical [] = True
vertical (h:t) = case h of 
                 Norte -> vertical t
                 Sul   -> vertical t 
                 _     -> False

--

data Posicao = Pos Int Int
             deriving Show

--

--47-- dada uma lista nao vazia de posiçoes, determina a que esta mais perto da origem

maisCentral ::  [Posicao] -> Posicao
maisCentral [(Pos x y)] = (Pos x y)
maisCentral ((Pos x y):(Pos xs ys):t) | (x^2)+(y^2) < (xs^2)+(ys^2) = maisCentral ((Pos x y):t) 
                                      | otherwise                               = maisCentral ((Pos xs ys):t)


--48--dada uma posiçao e uma lista de posiçoes, selecciona da lista as posiçoes adjacentes à posiçao dada.

vizinhos ::  Posicao -> [Posicao] -> [Posicao]
vizinhos _ [] = []
vizinhos (Pos x y) ((Pos xs ys):t) | (abs(x-xs)==0 || abs(x-xs)==1) && (abs(y-ys)==0 || abs(y-ys)==1) = (Pos xs ys):vizinhos (Pos x y) t 
                                   | otherwise                                                        = vizinhos (Pos x y) t

--49-- que testa se todas as poscoes de uma dada lista tem a mesma ordenada

mesmaOrdenada ::  [Posicao] -> Bool
mesmaOrdenada [] = True
mesmaOrdenada [x] = True
mesmaOrdenada ((Pos x y):(Pos xs ys):t) | y==ys     = mesmaOrdenada ((Pos xs ys):t)
                                        | otherwise = False

--

data Semaforo = Verde | Amarelo | Vermelho
              deriving Show

--

--50-- testa se o estado dos semmaforos de um cruzamento é seguro, i.e., nao ha mais do que semaforo nao vermelho.

interseccaoOK ::  [Semaforo] -> Bool
interseccaoOK [] = True
interseccaoOK l = (aux l)<=1
              where
                aux (Verde:resto) = 1+aux resto
                aux (h:t) = aux t
                aux _ = 0
------------------------------------------------------------------------------------------------------------------------------------------------------------


















