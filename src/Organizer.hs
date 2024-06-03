{-# LANGUAGE DeriveGeneric #-}

module Organizer (newOrganizer, draw, newNode, apply) where

import Data.Serialize (Serialize)
import Data.Tree (Tree, drawTree, Tree(Node))
import Data.UUID (UUID, toString)
import Data.UUID.V4 (nextRandom)

import GHC.Generics (Generic)

data ONode = ONode {
    nodeId      :: UUID,
    label   :: String
}

internalLabel :: ONode -> String
internalLabel n = (toString (nodeId n)) ++ " " ++ label n

newOrganizer :: IO (Tree ONode)
newOrganizer = do
    newId <- nextRandom
    return (Node (ONode  newId "root") [])

data Operation = NewNode { newLabel :: String }

newNode :: String -> Operation
newNode = NewNode

apply :: Tree ONode -> Operation -> IO (Tree ONode)
apply (Node root children) (NewNode nl) = do
    newId <- nextRandom
    return (Node root (children ++ [Node (ONode newId nl) []]))

draw :: (Tree ONode) -> String
draw o = drawTree $ fmap internalLabel o
