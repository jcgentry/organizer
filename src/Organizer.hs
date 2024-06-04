{-# HLINT ignore "Use <$>" #-}
{-# LANGUAGE DeriveGeneric #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Organizer (OHorizon (None), newOrganizer, draw, newNode, apply, children, root, label, horizon) where

import Data.Binary (Binary)
import Data.Tree (Tree (Node), drawTree, rootLabel, subForest)
import Data.UUID (UUID, toString)
import Data.UUID.V4 (nextRandom)

import GHC.Generics (Generic)

------- OTree ---------

type OTree = Tree ONode

newOrganizer :: IO OTree
newOrganizer = do
    newId <- nextRandom
    return (Node (ONode newId "root" None) [])

root :: OTree -> ONode
root = rootLabel

children :: OTree -> [OTree]
children = subForest

apply :: OTree-> Operation -> IO (Tree ONode)
apply (Node r cs) (NewNode l h) = do
    newId <- nextRandom
    return (Node r (cs ++ [Node (ONode newId l h) []]))

draw :: Tree ONode -> String
draw o = drawTree $ fmap internalLabel o

-------- ONode -----------

data ONode = ONode
    { nodeId :: UUID
    , label :: String
    , horizon :: OHorizon
    }
    deriving (Eq, Show, Generic)

instance Binary ONode

internalLabel :: ONode -> String
internalLabel n = toString (nodeId n) ++ " " ++ label n

----- OHorizon -----
data OHorizon = Life | TenYears | FiveYears | ThreeYears | OneYear | Epic | Project | Task | None
    deriving (Eq, Show, Generic)

instance Binary OHorizon


----- Operation -----

data Operation = NewNode String OHorizon

newNode :: String -> OHorizon -> Operation
newNode = NewNode

