module Main where

import System.Environment (getArgs)
import System.Directory (doesDirectoryExist)
import Control.Conditional (ifM)
import Lib

main :: IO ()
main = do
    args <- getArgs
    case args of
        []  -> putStrLn "I need a directory path! (relative path allowed)"
        [x] -> ifM (doesDirectoryExist x) 
                (startSearch x) (putStrLn "No such directory was found!")
        _   -> putStrLn "Too many things! Type in only the directory path."