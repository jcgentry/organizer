module Main (main) where

import Organizer (newOrganizer, newNode, apply, draw)       

main :: IO ()
main = do
        o <- newOrganizer
        let op = newNode "new"
        o' <- apply o op
        putStrLn (draw o')
