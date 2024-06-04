{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use <$>" #-}

{-# LANGUAGE DeriveGeneric #-}

module Organizer (newOrganizer, draw, newNode, apply, children, root, label) where

import Data.Binary (Binary, get, put)
import Data.Tree (Tree (Node), drawTree, rootLabel, subForest)
import Data.UUID (UUID, toString)
import Data.UUID.V4 (nextRandom)

import GHC.Generics (Generic)

------- OTree ---------

type OTree = Tree ONode

newOrganizer :: IO OTree
newOrganizer = do
    newId <- nextRandom
    return (Node (ONode newId "root") [])

root :: OTree -> ONode
root = rootLabel

children :: OTree -> [OTree]
children = subForest

apply :: Tree ONode -> Operation -> IO (Tree ONode)
apply (Node r c) (NewNode nl) = do
    newId <- nextRandom
    return (Node r (c ++ [Node (ONode newId nl) []]))

draw :: Tree ONode -> String
draw o = drawTree $ fmap internalLabel o

-------- ONode -----------

data ONode = ONode
    { nodeId :: UUID
    , label :: String
    } deriving (Eq, Show, Generic)

instance Binary ONode

internalLabel :: ONode -> String
internalLabel n = toString (nodeId n) ++ " " ++ label n

----- Operation -----

newtype Operation = NewNode String

newNode :: String -> Operation
newNode = NewNode
