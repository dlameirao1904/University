
module Ficha3 where
import Data.Char
import Data.Int

--ficha 3

--1)

data Hora = H Int Int
         deriving (Show,Eq)

type Etapa = (Hora,Hora)
type Viagem = [Etapa]


--1.a) testar se a etapa esta bem construida

validaEtapa :: Etapa -> Bool
validaEtapa (h1,h2) = horaValida h1 && horaValida h2 && h2 `horaDepois` h1
                   where
                    horaValida :: Hora -> Bool
                    horaValida (H h m) = if h `elem` [0..23] && m `elem` [0..59] then True else False
                    horaDepois :: Hora -> Hora -> Bool
                    (H h m) `horaDepois` (H h2 m2) = (h,m) >= (h2,m2)
                  
--1.b) testar se uma viagem esta bem construida

validaViagem :: Viagem -> Bool
validaViagem [] = False
validaViagem (eta:[]) = validaEtapa eta
validaViagem ((e,ek):(e2,e2k):et) = validaEtapa (e,ek) && validaEtapa (ek,e2k) && validaViagem ((e2,e2k):et)

--1.c) calcular a hora de partida e chegada de uma dada viagem

partEcheg :: Viagem -> (Hora,Hora)
partEcheg [(h1,h2)] = (h1,h2)
partEcheg [(h1,h2),(h3,h4)] = (h1,h4)
partEcheg ((h1,h2):(h3,h4):t) = partEcheg ((h1,h2):t)

--1.d)Dada uma viagem valida, calcular o tempo total da viagem efetiva

horaMin :: Hora -> Int
horaMin (H h m) = 60 * h + m

minHora :: Int -> Hora
minHora x = (H (div x 60) (mod x 60))

------------------------------------------------

tempoViagem :: Viagem -> Hora
tempoViagem [(h1,h2)] = minHora ((horaMin h2) - (horaMin h1))
tempoViagem ((h1,h2):et) = minHora (((horaMin h2) - (horaMin h1)) + (horaMin (tempoViagem et))) 

--1.e) calcular o tempo total de espera

tempoEspera :: Viagem -> Hora
tempoEspera [(h1,h2)] = H 0 0
tempoEspera ((h1,h2):(h3,h4):et) = minHora (((horaMin h3)-(horaMin h2)) + (horaMin (tempoEspera ((h3,h4):et))))

--1.f) tempo total da viagem

tempoTotal :: Viagem -> Hora
tempoTotal l = minHora ((horaMin (tempoViagem l)) + (horaMin (tempoEspera l)))

--2

data Ponto = Cartesiano Double Double | Polar Double Double
             deriving (Show,Eq)

type Poligonal = [Ponto]
--------------------------------------

posx :: Ponto -> Double
posx ponto = case ponto of Cartesiano x y -> x 
                           Polar r a -> if a == pi/2 then 0 else (r * cos a)

posy :: Ponto -> Double
posy ponto = case ponto of Cartesiano x y -> y
                           Polar r a -> if a==pi then 0 else (r * sin a)

dist :: Ponto -> Ponto -> Double
dist p1 p2 = sqrt $ ((posx p2 - posx p1)^2) + ((posy p2 - posy p1)^2)

---------------------------------------

--2.a) calcular o comprimento de uma linha poligonal

comprimento :: Poligonal -> Double
comprimento [p1] = 0
comprimento (p1:p2:ps) = dist p1 p2 + comprimento (p2:ps)

--2.b) testar se uma linha poligonal é fechada

linhaFA :: Poligonal -> Bool
linhaFA [p1,p2] = False
linhaFA [p1,p2,p3] = if p3 == p1 then True else False
linhaFA (p1:p2:p3:ps) = linhaFA (p1:p3:ps)

-----------------------------------------

data Figura = Circulo Ponto Double
            | Retangulo Ponto Ponto 
            | Triangulo Ponto Ponto Ponto 
              deriving (Show,Eq)

-----------------------------------------

area :: Figura -> Double
area (Triangulo p1 p2 p3) = 
       let a = dist p1 p2 
           b = dist p2 p3
           c = dist p3 p1
           s = (a+b+c) / 2 -- semi-perimetro
        in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron
area (Circulo _ r) = pi * r^2
area (Retangulo p1 p2) = abs (posx p2 - posx p1) * abs (posy p2 - posy p1) 

-----------------------------------------

--2.c) calcula uma lista de triangulos cuja soma das areas seja igual a area limitada pel linha poligonal

triangula :: Poligonal -> [Figura]
triangula [p1,p2,p3] = [(Triangulo p1 p2 p3)]
triangula (p1:p2:p3:ps) = (Triangulo p1 p2 p3) : triangula (p1:p3:ps)

--2.d) calcula a area definida por uma linha poligonal fechada

areaPol :: Poligonal -> Double
areaPol p = sum (map (\fig -> area fig) (triangula p))

-- nao percebi esta soluçao

--2.e) dada uma linha poligonal e um ponto, o output sera a mesma linha poligonal mas iniciada no ponto dado

mover :: Poligonal -> Ponto -> Poligonal
mover polig p1 = p1:polig

--2.f) dado um fator de escala e uma linha poligonal dê como resultado uma linha poligonal semelhante com o mesmo ponto inicial mas em que o comprimento em cada segmento de reta  é multiplicado por esse fator

zoom :: Double -> Poligonal -> Poligonal
zoom z [p1@(Cartesiano x y),p2@(Cartesiano a b)]     = [p1,(Cartesiano (z*a) (z*b))]
zoom z (p1@(Cartesiano x y):p2@(Cartesiano a b):pol) = p1:zoom z (p2:pol)
                                                     where p2 = (Cartesiano (z*a) (z*b))

--3

-------------------------------------------------
data Contacto = Casa Integer 
              | Trab Integer
              | Tlm Integer
              | Email String
              deriving Show

type Nome = String
type Agenda = [(Nome,[Contacto])]
-------------------------------------------------

--3.a) dado um nome, um email e uma agenda acrescenta essa informaçao a agenda

acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail nome email agenda = agenda ++ [(nome, [Email email])]

--2.b) dado um nome e uma agenda retorna a lista dos emails associados a esse nome. senao retorna nothing

verEmails :: Nome -> Agenda -> Maybe [String]
verEmails nome [(n,c)] = if nome == n then Just (map (\x -> case x of Email e -> e) c) else Nothing
verEmails nome ((n,c):agenda) = if nome == n then verEmails nome [(n,c)] else verEmails nome agenda

--3.c) dada uma lista de contactos retorna todos os numeros de telefone, tanto os fixos como os moveis, dessa lista

consTelefs :: [Contacto] -> [Integer]
consTelefs [] = []
consTelefs (c:cs) = case c of Casa x -> x:consTelefs cs
                              Trab x -> x:consTelefs cs
                              Tlm x -> x:consTelefs cs
                              otherwise -> consTelefs cs

--3.d) dado um nome e uma agenda retorna o numero de telefone dde casa

casa :: Nome -> Agenda -> Maybe Integer
casa nome [(n,(c:cs))] = if nome == n then case c of Casa x -> Just x
                                                     otherwise -> casa nome [(n,cs)]
                                      else Nothing
casa nome ((n,c):agenda) = if nome == n then casa nome [(n,c)] else casa nome agenda 

--4

----------------------------------------

type Dia = Int
type Mes = Int
type Ano = Int

data Data = D Dia Mes Ano 
            deriving Show 

type TabDN = [(Nome,Data)]

-----------------------------------------  

--4.a) indica a data de nascimento de uma pessoa caso o nome dessa pessoa exista na tabela

procura :: Nome -> TabDN -> Maybe Data
procura nome [(n,d)] = if nome == n then Just d else Nothing 

--4.b) calcula a idade de uma pessoa

idade :: Data -> Nome -> TabDN -> Maybe Int
idade (D d1 m1 a1) nome ((n,(D d2 m2 a2)):t) = if nome==n && m1>m2 || m1==m2 && a1>a2 then Just (a1-a2) else idade (D d1 m1 a1) nome t  
                                        

-- 4.c) testa se uma data é anterior a outra

anterior :: Data -> Data -> Bool
anterior (D d1 m1 a1) (D d2 m2 a2) = a1<a2 || a1==a2 && m1<m2 || m1==m2 && d1<d2

--4.d) ordena a tabela de datas de nascimento por ordem crescente 

ordena :: TabDN -> TabDN
ordena [] = []
ordena ((n,d):t) = organiza (n,d) (ordena t)
                 where 
                    organiza (n,d) [] = [(n,d)]
                    organiza (n,d) ((nh,dh):t) | anterior dh d = (nh,dh):organiza (n,d) t
                                               | otherwise = (n,d):(nh,dh):t 

--4.e) consoante a idade das pessoas, organiza os nomes, por ordem crescente

porIdade :: Data -> TabDN -> [(Nome,Int)]
porIdade d [] = []
porIdade (D d m a) tabela = (n,idade):porIdade (D d m a) ts
                          where 
                            ((n,D d2 m2 a2):ts) = ordena tabela
                            idade = if m>m2 || m2==m && d>d2 then (a - a2) else ((a - a2) - 1)

--5

-------------------------------------

data Movimento = Credito Float | Debito Float
               deriving Show

data Extracto = Ext Float [(Data,String,Movimento)]
              deriving Show

--------------------------------------

--5.a) produzuma lista de todos os movimentos superiores a um determinado valor

extValor :: Extracto -> Float -> [Movimento]
extValor (Ext n []) _ = []   
extValor (Ext n ((d,s,Credito k):t)) x = if k>x then (Credito k):extValor (Ext n t) x else extValor (Ext n t) x      
extValor (Ext n ((d,s,Debito k):t)) x = if k>x then (Debito k):extValor (Ext n t) x else extValor (Ext n t) x  

--5.b) retorna informaçao relativa aos movimentos cuja descriçao esteja incluida na lista fornecida no segundo parametro

filtro :: Extracto -> [String] -> [(Data,Movimento)]
filtro (Ext n []) _ = []
filtro (Ext n ((d,s,mov):ts)) lista = if s `elem` lista then (d,mov):filtro (Ext n ts) lista else filtro (Ext n ts) lista 

--5.c) retorna o total de creditos e debitos de um extrato no primeiro e segundo elemento de um par respetivamente

creDeb :: Extracto -> (Float,Float)
creDeb (Ext l []) = (0,0)
creDeb (Ext l ((d,s,m):t)) = case m of
                             Credito x -> (x+e , f)
                             Debito x -> (e , f+x)

--5.d) devolve o saldo final que resulta da execuçao de todos os movimentos  no extrato sobre o saldo inicial

--saldo :: Extracto -> Float
--saldo (Ext n []) = n
--saldo (Ext n ((d,s,Credito k):t)) = k + saldo (Ext n t)

saldo :: Extracto -> Float
saldo (Ext x lm) = foldl (\acc (_,_,mov) -> case mov of Credito n -> (acc + n)
                                                        Debito n -> (acc - n)) x lm 

----------------------------------------------------------------














