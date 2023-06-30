module Ficha08 where

import Data.List
import Data.Char

--1

data Frac = F Integer Integer

--1.b) Defina Frac como instância da classe Eq.

instance Eq Frac where
    (F a b) == (F c d) = a * d == c * b

--1.d) Defina Frac como instância da classe Show, de forma a que cada fraçao seja apresentada por (numerador/denominador).

instance Show Frac where
    show (F a b) = show a ++ " / " ++ show b

 --1.e) Defina Frac como instância da classe Num

{-instance Num Frac where
    -- (+), (*), (-) :: a -> a -> a
    -- negate, abs, signum :: a -> a
    -- fromInteger :: Integer -> a
    (F a b) + (F c d) | b == d = normaliza $ F (a + c) b
                      | otherwise = normaliza $ F (a * d + b * c) (b * d)
    x - y = x + negate y
    (F a b) * (F c d) = F (a * c) (b * d)
    negate (F a b) = F (-a) b
    abs (F a b) = F (abs a) (abs b)
    signum (F a b) | a == 0 = 0
                   | a * b > 0 = 1
                   | otherwise = (-1)
    fromInteger x = F x 1
--1.b) Defina Frac como instância da classe Ord

instance Ord Frac where
    (F a b) <= (F c d) = a * d <= c * b
-}

--1.a) dada uma fraçao calcula uma fraçao equivalente, irredutivel, e com o denominador positivo.

mdc :: Integer -> Integer -> Integer
--mdc x y == mdc (x+y) y == mdc x (y+x)
mdc a b = last [n | n <- [1..minor a b] , mod a n == 0 , mod b n == 0]
--where
--   minor :: Int -> Int -> Int 
--   minor a b | if a<b = a
--           | otherwise = b
--


normaliza :: Frac -> Frac
normaliza  (F a b) = F (aX `div` x) (bX `div` x)
                   where
                     x = mdc (abs a) (abs b) * (if a * b < 0 then (-1) else 1)
                     aX = if a < 0 then (-a) else a
                     bX = if b < 0 then (-b) else b

-- 2

data Exp a = Const a
           | Simetrico (Exp a)
           | Mais (Exp a) (Exp a)
           | Menos (Exp a) (Exp a)
           | Mult (Exp a) (Exp a)

--2.a) a) Declare Exp a como uma instância de Show.

instance Show a => Show (Exp a) where
    show (Const a) = show a
    show (Simetrico a) = "(-" ++ show a ++ ")"
    show (Mais a b) = "(" ++ show a ++ "+" ++ show b ++ ")"
    show (Menos a b) = "(" ++ show a ++ "-" ++ show b ++ ")"
    show (Mult a b) = "(" ++ show a ++ "*" ++ show b ++ ")"

--2.b) Declare Exp a como uma instância de Eq.

valorDe :: (Num a) => Exp a -> a
valorDe (Const a) = a
valorDe (Simetrico a) = - (valorDe a)
valorDe (Mais a b) = valorDe a + valorDe b
valorDe (Menos a b) = valorDe a - valorDe b
valorDe (Mult a b) = valorDe a * valorDe b

--1.c) Declare Exp a como uma instância de Num.

instance (Num a,Eq a) => Eq (Exp a) where
    x == y = valorDe x == (valorDe y)

instance (Num a, Eq a) => Num (Exp a) where
    x + y = Const (valorDe x + valorDe y)
    --
    x - y = Const (valorDe x - valorDe y)
    --
    x * y = Const (valorDe x * valorDe y)
    --
    negate (Const a) = Const (- a)
    negate (Simetrico a) = a
    negate (Mais a b) = Mais (- a) (- b)
    negate (Menos a b) = Menos b a
    negate (Mult a b) = Mult (-a) b
    fromInteger x = Const (fromInteger x)
    abs (Const a) = Const (abs a)
    abs (Simetrico a) = abs a
    abs (Mais a b) = abs (a + b)
    abs (Menos a b) = abs (a - b)
    abs (Mult a b) = abs (a * b)
    signum (Const a) = Const (if abs a == a then if a == 0 then 0 else 1 else (-1))
    signum (Simetrico a) = - signum a
    signum (Mais a b) = Const (if abs (a + b) == a + b then if a + b == 0 then 0 else 1 else (-1))
    signum (Menos a b) = Const (if abs (a - b) == a - b then if a - b == 0 then 0 else 1 else (-1))
    signum (Mult a b) = Const (if abs (a * b) == a * b then if a * b == 0 then 0 else 1 else (-1))

--3

data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
data Extracto = Ext Float [(Data, String, Movimento)]

--3.a) Defina Data como instancia da classe Ord.

instance Ord Data where
    compare (D dia1 mes1 ano1) (D dia2 mes2 ano2) | ano1 > ano2 || ano1 == ano2 && (mes1 > mes2 || mes1 == mes2 && dia1 > dia2) = GT
                                                  | ano1 == ano2 && mes1 == mes2 && dia1 == dia2 = EQ
                                                  | otherwise = LT

--3.b) Defina Data como instância da classe Show.

instance Show Data where 
    show (D dia mes ano) = concat $ intersperse "/" $ map (show) [dia,mes,ano]

--3.c) transforma um extracto de modo a que a lista de movimentos apareça ordenada por ordem crescente de data.

ordena :: Extracto -> Extracto
ordena (Ext n l) = (Ext n (sortBy (\(data1,_,_) (data2,_,_) -> compare data1 data2) l))

--3.d) Defina Extracto como instˆancia da classe Show, de forma a que a apresentaçao do
--extracto seja por ordem de data do movimento com o seguinte, e com o seguinte
--aspecto
{-
Saldo anterior: 300
---------------------------------------
Data Descricao Credito Debito
---------------------------------------
2010/4/5 DEPOSITO 2000
2010/8/10 COMPRA 37,5
2010/9/1 LEV 60
2011/1/7 JUROS 100
2011/1/22 ANUIDADE 8
---------------------------------------
Saldo actual: 2294,5
-}

instance Show Extracto where
    show (Ext n l) = "Saldo anterior: " ++ show n ++
                     "\n---------------------------------------" ++
                     "\nData       Descricao   Credito   Debito" ++
                     "\n---------------------------------------\n" ++ concatMap (\(dat,str,mov) -> show dat ++ replicate (11 - (length (show dat))) ' ' ++ map (toUpper) str ++ "    \n") l ++
                     "---------------------------------------" ++
                     "\nSaldo actual: " ++ show (saldo (Ext n l))

saldo :: Extracto -> Float
saldo (Ext x lm) = foldl (\acc (_,_,mov) -> case mov of Credito n -> (acc + n)
                                                        Debito n -> (acc - n)) x lm




