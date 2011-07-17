import Data.Bits

a = 0x00
b = 0x09
c = 0x17
d = 0x1e
e = 0x23
f = 0x2a
g = 0x34
h = 0x3d

codewords = [a,b,c,d,e,f,g,h]
pairs = [(x,y) | x <- codewords, y <- codewords, x < y]

bitVal :: Int -> Int -> Int
bitVal n i = if testBit n i then 1 else 0

countbits :: Int -> Int
countbits n = (bitVal n 0) + (bitVal n 1) + (bitVal n 2) + (bitVal n 3)
      + (bitVal n 4) + (bitVal n 5)

errors = map (uncurry xor) pairs

distances = map countbits errors
