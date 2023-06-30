
module Ficha01 where
import Data.Char

--1.a) funçao que calculao perimetro de uma circunferencia dado o seu raio

perimetro :: Double -> Double
perimetro r = 2 * pi * r

--1.b) funçso que calcula a distancia entre dois pontos no plano

dist :: (Double,Double) -> (Double,Double) -> Double
dist (x1,y1) (x2,y2) = sqrt ((x2-x1)^2+(y2-y1)^2)

--1.c) funçao que recebe uma lista e devolve um par com o primeiro e ultimo elemento dessa lista

primUlt :: [Int] -> (Int,Int)
primUlt l = (head l, last l) 

--1.d) funçao que testa o nº inteiro m é multiplo do nº inteiro n

multiplo :: Int -> Int -> Bool
multiplo x y = if mod x y == 0 then True else False

--1.e) funçao que recebe uma lista e se o comprimento da lista for impar, retira a head, caso contrario devolve a propria

truncaImpar :: [Int] -> [Int]
truncaImpar l = if mod (length l) 2 == 0 then l else tail l 

--1.f) funçao que calcula o maior de 2 inteiros

max2 :: Int -> Int -> Int
max2 x y = if x>y then x else y 

--1.g) funçao que calcula o maior de 3 inteiros

max3 :: Int -> Int -> Int -> Int
max3 x y k = max2 (max2 x y) k

--2.a) funçao que recebe os 3 coeficientes de um polinomio de 2º grau e calcula o nº de raizes reais desse polinomio

nRaizes :: Double -> Double -> Double -> Int
nRaizes a b c | delta == 0 = 1 
              | delta > 0  = 2 
              | otherwise  = 0
             where
                delta = b^2 - 4*a*c

--2.b) funçao (que usando a funçao anterior) recebe os coeficientes de um polinomio de 2º grau e calcula a lista das raizes reais

raizes :: Double -> Double -> Double -> [Double]
raizes a b c | nRaizes a b c == 2 = [(-b + delta)/2*a,(-b - delta)/2*a]
             | nRaizes a b c == 1 = [-b/2*a]
             | nRaizes a b c == 0 = []
             where
                delta = b^2 - 4*a*c

--3

type Hora = (Int,Int)

--3.a) funçao que testa se uma hora é valida é ou nao

valida :: Hora -> Bool
valida (h,m) = if (h>=0 && h<=23) && (m>=0 && m<=59) then True else False

--3.b) funçao que testa se uma hora é depois ou da outra ou nao

compara :: Hora -> Hora -> Bool
compara (h1, m1) (h2, m2) = h1>h2 || h1==h2 && m1>m2

--3.c) funçao que converte horas (par de inteiros) para minutos (inteiros) 

convertMin :: Hora -> Int
convertMin (h,m) = h * 60 + m

--3.d) conveter um valor em minutos para horas

convertHora :: Int -> Hora
convertHora x = (h,m)
             where
                h = mod (div x 60) 24
                m = mod x 60

--3.e) calcular a diferença entre duas horas (cujo resultado deve aparecer em minutos)

difHora :: Hora -> Hora -> Int
difHora (h1,m1) (h2,m2) =  abs $ b - a 
                       where
                        a = convertMin (h1,m1)
                        b = convertMin (h2,m2)

--3.f) funçao que adiciona um determinado nº de minutos a uma certa hora

adiciona :: Hora -> Int -> Hora
adiciona (h,m) k = convertHora (convertMin (h,m) + k)

--4 (= à pergunta 3)(para testar a por em comentario toda a tres se nao o compilador nao consegue reconhecer qual type receber)

data Hora = H Int Int deriving (Show,Eq)

--4.a)

valida' :: Hora -> Bool
valida' (H h m) = if elem h [0..23] && elem m [0..59] then True else False

--4.b)

horaDepois :: Hora -> Hora -> Bool
(H h m) `horaDepois` (H h2 m2) = (h,m) >= (h2,m2)

--4.c)

horamin :: Hora -> Int
horamin (H h m) = h * 60 + m

--4.d) 

minhora :: Int -> Hora
minhora x =  (H (div x 60) (mod x 60))

--4.e) 

horadiff :: Hora -> Hora -> Int
horadiff (H h1 m1) (H h2 m2) = abs $ x - y
                            where
                                x = horamin (H h1 m1)
                                y = horamin (H h2 m2)

--4.f) 

admin :: Int -> Hora -> Hora
admin x (H h m) = minhora (horamin (H h m) + x)

--5

data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

--5.a) calcula o proximo estado de um semaforo

next :: Semaforo -> Semaforo
next x = case x of Verde -> Amarelo
                   Amarelo -> Vermelho
                   Vermelho -> Verde

--5.b) determina se é ou nao obrigatório parar num semaforo

stop :: Semaforo -> Bool
stop x = if x==Vermelho then True else False

--5.c) testa se o estado de dois semaforos num cruzamento é seguro.

safe :: Semaforo -> Semaforo -> Bool
safe s1 s2 = s1==Vermelho || s2==Vermelho

--6

data Ponto = Cartesiano Double Double | Polar Double Double
             deriving (Show,Eq)

--6.a) calcular a distancia do ponto ao eixo do y

posx :: Ponto -> Double
posx ponto = case ponto of Cartesiano x y -> x 
                           Polar r a -> if a == pi/2 then 0 else (r * cos a)

--6.b) calcular a distancia do ponto ao eixo do x

posy :: Ponto -> Double
posy ponto = case ponto of Cartesiano x y -> y
                           Polar r a -> if a==pi then 0 else (r * sin a)

--6.c) calcular a distancia do ponto a origem

raio :: Ponto -> Double   
raio ponto = case ponto of Cartesiano x y -> sqrt $ x^2 + y^2
                           Polar r a -> r  

--6.d) calcula o angulo entre o vetor que liga a origem a um ponto e o eixo horizontal

angulo :: Ponto -> Double
angulo ponto = case ponto of Polar r a -> a 
                             Cartesiano x y -> if x>0 && y==0 then 0 else
                                               if x<0 && y==0 then pi else
                                               if x==0 && y>0 then (pi/2) else
                                               if x==0 && y<0 then ((3*pi)/2) else atan (y/x) 

--6.e) calcula a distancia entre dois pontos

dista :: Ponto -> Ponto -> Double
dista p1 p2 = sqrt $ ((posx p2 - posx p1)^2) + ((posy p2 - posy p1)^2)

--7

data Figura = Circulo Ponto Double
            | Retangulo Ponto Ponto 
            | Triangulo Ponto Ponto Ponto 
              deriving (Show,Eq)

--7.a) testa se uma figura é um poligono

poligono :: Figura -> Bool
poligono (Circulo c r) = False
poligono (Retangulo p1 p2) = posx p1 /= posx p2 && posy p1 /= posy p2
poligono (Triangulo p1 p2 p3) = (posy p2 - posy p1)/(posx p2 - posx p1) /= (posy p3 - posy p2)/(posx p3 - posx p2)

--7.b) calcula a lista de vertices de um poligono

vertices :: Figura -> [Ponto]
vertices (Circulo c r) = []
vertices ret@(Retangulo p1 p2) = if poligono ret then [p1,Cartesiano (posx p1) (posy p2),Cartesiano (posx p2) (posy p1),p2] else []
vertices tri@(Triangulo p1 p2 p3) = if poligono tri then [p1,p2,p3] else []

--7.c) calcula area de uma figura 

area :: Figura -> Double
area (Triangulo p1 p2 p3) = 
       let a = dista p1 p2
           b = dista p2 p3
           c = dista p3 p1
           s = (a+b+c) / 2 -- semi-perimetro
        in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron
area (Circulo _ r) = pi * r^2
area (Retangulo p1 p2) = abs (posx p2 - posx p1) * abs (posy p2 - posy p1) 

--7.d) calcula o perimetro de uma figura

perim :: Figura -> Double
perim (Circulo _ r) = 2 * pi * r
perim (Retangulo p1 p2) = 2 * abs (posx p2 - posx p1) + 2 * abs (posy p2 - posy p1)
perim (Triangulo p1 p2 p3) = dista p1 p2 + dista p2 p3 + dista p3 p1

--8.a) testa se um Char é uma minusculo

isLower :: Char -> Bool 
isLower x = x `elem` ['a'..'z']

--8.b) testa se um Char é um digito

isDigit :: Char -> Bool
isDigit x= x `elem` ['0'..'9']

--8.c) testa se um Char é uma letra 

isAlpha :: Char -> Bool
isAlpha x = x `elem` ['a'..'z'] || x `elem` ['A'..'Z']

--8.d) testa se um Char é uma maiscula

isUpper :: Char -> Bool
isUpper x = x `elem` ['A'..'Z']

--8.e) converte um numero entre 0 e 9 para o seu respetivo digito

intToDigit' :: Int -> Char
intToDigit' n = chr (n + 48)

--8.f) converte um digito para um Int 

digitToInt' :: Char -> Int 
digitToInt' x = ord x - 48

----------------------------------------------------------------------------------





