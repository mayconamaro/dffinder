module Lib where

import qualified Data.ByteString.Lazy as LB
import System.Directory (doesDirectoryExist, listDirectory)
import System.FilePath ((</>))
import Control.Monad (foldM)
import Control.Monad.Extra (partitionM) 
import Data.Digest.Pure.MD5 (md5, MD5Digest)
import Data.List (sortBy, intercalate, length)

startSearch :: FilePath -> IO ()
startSearch fp = getAllFiles fp 
                >>= checkMD5All 
                >>= putStrLn . (formatResult . findDuplicates)

getAllFiles :: FilePath -> IO [FilePath]
getAllFiles fp = getAllFiles' [] fp

getAllFiles' :: [FilePath] -> FilePath -> IO [FilePath]
getAllFiles' state fp = do
    names <- listDirectory fp
    let paths = map (fp </>) names
    (folders, files) <- partitionM doesDirectoryExist paths
    state' <- foldM (\xs x -> pure (x : xs)) state files
    foldM getAllFiles' state' folders

checkMD5All :: [FilePath] -> IO [(FilePath, MD5Digest)]
checkMD5All = mapM checkMD5 

checkMD5 :: FilePath -> IO (FilePath, MD5Digest)
checkMD5 fp = do
    file <- LB.readFile fp
    return (fp, md5 file)

findDuplicates :: [(FilePath, MD5Digest)] -> [(FilePath, FilePath)]
findDuplicates = findDOnSortedList . (sortBy (\x y -> compare (snd x) (snd y)))

findDOnSortedList :: [(FilePath, MD5Digest)] -> [(FilePath, FilePath)]
findDOnSortedList (x:y:ys) = if snd x == snd y 
                              then (fst x, fst y) : findDOnSortedList (y:ys)
                              else findDOnSortedList (y:ys)
findDOnSortedList _        = []

formatResult :: [(FilePath, FilePath)] -> String
formatResult l = "Found " ++ show (length l) ++ " duplicate files! \n"
                 ++ intercalate "\n" (map formatLine l)

formatLine :: (FilePath, FilePath) -> String
formatLine (x, y) = x ++ " is a duplicate of " ++ y