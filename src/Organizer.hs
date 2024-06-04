{-# HLINT ignore "Use <$>" #-}
{-# LANGUAGE DeriveGeneric #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Organizer (ONode (ONode), OTree, OHorizon (None), newOrganizer, draw, children, root, label, horizon, addTopLevelNodeToTree) where

import Data.Binary (Binary)
import Data.Tree (Tree (Node), drawTree, rootLabel, subForest)
import Data.UUID (UUID, toString)

import GHC.Generics (Generic)

------- OTree ---------

type OTree = Tree ONode

newOrganizer :: UUID -> OTree
newOrganizer id = Node (ONode id "root" None) []

root :: OTree -> ONode
root = rootLabel

children :: OTree -> [OTree]
children = subForest

draw :: Tree ONode -> String
draw o = drawTree $ fmap internalLabel o

addTopLevelNodeToTree :: OTree -> ONode -> OTree
addTopLevelNodeToTree tree node = tree { subForest = (subForest tree) ++ [Node node []] }


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


