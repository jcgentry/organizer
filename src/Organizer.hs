{-# HLINT ignore "Use <$>" #-}
{-# LANGUAGE DeriveGeneric #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Organizer (
    ONode (ONode),
    OTree,
    OHorizon (None),
    newOrganizer,
    drawTree,
    children,
    root,
    label,
    horizon,
    addTopLevelNodeToTree,
) where

import Data.Binary (Binary)
import qualified Data.Tree (Tree (Node), drawTree, rootLabel, subForest)
import Data.UUID (UUID, toString)

import GHC.Generics (Generic)

------- OTree ---------

type OTree = Data.Tree.Tree ONode

newOrganizer :: UUID -> OTree
newOrganizer rootNodeId = Data.Tree.Node (ONode rootNodeId "root" None) []

root :: OTree -> ONode
root = Data.Tree.rootLabel

children :: OTree -> [OTree]
children = Data.Tree.subForest

drawTree :: Data.Tree.Tree ONode -> String
drawTree o = Data.Tree.drawTree $ fmap internalLabel o

addTopLevelNodeToTree :: OTree -> ONode -> OTree
addTopLevelNodeToTree tree node = tree{Data.Tree.subForest = Data.Tree.subForest tree ++ [Data.Tree.Node node []]}

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
