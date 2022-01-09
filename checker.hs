import System.Directory.Internal.Prelude (getArgs)
import System.Exit (exitWith, ExitCode(..))
import GHC.IO.Buffer (checkBuffer)
import Control.Applicative ()
--
-- EPITECH PROJECT, 2022
-- pushswap_checker
-- File description:
-- pushswap_checker
--

rab :: [a] -> [a]
rab [] = []
rab (x:xs) = xs ++ [x]

rr :: [a] -> [b] -> ([a], [b])
rr a b = (rab a, rab b)

rrab :: [a] -> [a]
rrab [] = []
rrab xs = last xs : init xs

rrr :: [a] -> [b] -> ([a], [b])
rrr a b = (rrab a, rrab b)

sab :: [a] -> [a]
sab list = case list of
    x:y:xs -> y:x:xs
    [x] -> error "XXX"
    []-> error "XXX"

sc :: [a] -> [b] -> ([a], [b])
sc a b = (sab a, sab b)

pa :: [a] -> [a] -> ([a], [a])
pa a [] = (a, [])
pa a (b:bs) = (b : a, bs)

pb :: [a] -> [a] -> ([a], [a])
pb b [] = (b, [])
pb b (a:as) = (as, a : b)


listIsSort :: (Ord a) => [a] -> Bool
listIsSort [] = True
listIsSort [x] = True
listIsSort (x:y:xs) = x <= y && listIsSort (y:xs)

isOperation :: [Char] -> Bool
isOperation a
    | a == "sa" || a == "sb" || a == "sc" || a == "pa" || a == "pb" ||
    a == "ra" || a == "rb" || a == "rr" || a == "rra" || a == "rrb"||
    a == "rrr" = True
    | otherwise = False

checkAllOps :: [[Char]] -> Bool
checkAllOps [] = True
checkAllOps (x:xs) = (isOperation x) && checkAllOps xs

isFullNumbers :: [Char] -> Bool
isFullNumbers [] = True
isFullNumbers (x:xs)
    | ((x >= '0' || x <= '9') || x == '-') = isFullNumbers xs
    | otherwise = False

numberChecker :: [[Char]] -> Bool
numberChecker [] = True
numberChecker (a:as) =
    (isFullNumbers a) && numberChecker as

stringsToInts :: [String] -> [Int]
stringsToInts = map read

checkArgs :: [[Char]] -> [[Char]] -> IO ()
checkArgs [] wrd = do { putStrLn "KO"; exitWith (ExitFailure 84) }
checkArgs lyst wrd = do
    if numberChecker lyst && checkAllOps wrd
        then do { isSorted lyst wrd  }
        else do { putStrLn "KO"; exitWith (ExitFailure 84) }


isSorted :: [[Char]] -> [[Char]] -> IO ()
isSorted lyst wrd = do
    let intList = stringsToInts lyst
    if listIsSort (intList)
        then do { putStrLn "OK"; return ()  }
        else do { endCheck wrd (intList) }


endCheck :: [[Char]] -> [Int] -> IO ()
endCheck wrd intList = do
    let nimp = fst (applyAllOpps wrd (intList, []))
    if listIsSort nimp
        then do { putStrLn "OK"; return ()}
        else do { putStr "KO: "; print (applyAllOpps wrd (intList, [])) ;exitWith (ExitFailure 84) }

applyOpps :: [Char] -> ([Int], [Int]) -> ([Int], [Int])
applyOpps x (la, lb) = case x of
    "sa" -> (sab la, lb)
    "sb" -> (la, sab lb)
    "sc" -> (sc la lb)
    "pa" -> pa la lb
    "pb" -> pb lb la
    "ra" -> (rab la, lb)
    "rb" -> (la, rab lb)
    "rr" -> rr la lb
    "rra" -> (rrab la, lb)
    "rrb" -> (la, rrab lb)
    "rrr" -> rrr la lb
    _     -> ([], [])

applyAllOpps :: [String] -> ([Int], [Int]) -> ([Int], [Int])
applyAllOpps [] (la, lb) = (la, lb)
applyAllOpps (x:xs) (la, lb) = applyAllOpps xs (applyOpps x (la, lb))


main :: IO ()
main = do
    lyst <- getArgs
    ops <- getLine
    checkArgs lyst (words ops)