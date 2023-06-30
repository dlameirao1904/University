module Ficha09 where

import System.Random
import Data.Char
import Data.List
import Data.Maybe
import qualified Data.Text as Text
import Control.Monad



principal = do 
               num <- randomRIO (1::Int, 50)
               adivinhar num 

adivinhar num = do
                   putStr "\nDigite um numero entre 1 e 50:"
                   n <- getLine 
                   if (read n) < num
                   then do 
                        putStr "\nO numero é superior!"
                        adivinhar num
                   else if (read n) > num
                   then do 
                            putStr "\nO numero é inferior"
                            adivinhar num
                   else do 
                            putStr "\nParabens!! Está certo!! Quer jogar mais um jogo? \n Sim/Nao \n"
                   if (read n) == "Sim" || "sim"
                   then do 
                        putStr "Prepara-te!"
                   else do
                        putStr "Foi um prazer jogar contigo!"     












