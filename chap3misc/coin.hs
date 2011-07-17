module Main where
import Prelude hiding (flip)

main = putStrLn solveAll

data Coin = Heads Int | Tails Int deriving (Show, Eq, Read)

flip :: Coin -> Coin
flip (Heads n) = Tails n
flip (Tails n) = Heads n

data Position = A | B deriving (Show, Eq, Read)

data Game = Game Coin Coin deriving (Show, Eq, Read)

switch :: Game -> Game
switch (Game a b) = Game b a

flipPos :: Position -> Game -> Game
flipPos A (Game a b) = Game (flip a) b
flipPos B (Game a b) = Game a (flip b)

move :: Int -> Game -> Game
move 0 = id 
move 1 = flipPos A 
move 2 = flipPos B
move 3 = flipPos A . flipPos B
move 4 = switch
move 5 = switch . flipPos A
move 6 = switch . flipPos B
move 7 = switch . flipPos B . flipPos A

same :: Int -> Int -> Int -> Game -> Bool
same n1 n2 m g = (move n2 (move n1 g)) == move m g

game = Game (Heads 1) (Heads 2)

m0 = move 0 game
m1 = move 1 game
m2 = move 2 game
m3 = move 3 game
m4 = move 4 game
m5 = move 5 game
m6 = move 6 game
m7 = move 7 game
                 
solve :: Int -> Int -> String
solve m n = let target = (move n (move m game)) in
   if target == m0 then "0" else
   if target == m1 then "1" else
   if target == m2 then "2" else
   if target == m3 then "3" else
   if target == m4 then "4" else
   if target == m5 then "5" else
   if target == m6 then "6" else "7"

printOne :: ((Int, Int), String) -> String
printOne ((m,n),s) = ("M" ++ show m) ++ "*" ++ ("M" ++ show n) ++ "=" ++ s ++ "\n"

printAll :: [((Int,Int), String)] -> String
printAll l = foldl (++) "" (map printOne l)

solveAll = let moves = [0..7]
               ops = [(x,y) | x <- moves, y <- moves]
               answers = map (uncurry solve) ops
               both = zip ops answers
           in
               printAll both
               
