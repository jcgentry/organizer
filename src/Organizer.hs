module Organizer (newOrganizer, draw, newNode, apply, root, children, label) where

import Data.Tree (Tree, Tree(Node), subForest, drawTree, rootLabel)
import Data.UUID (UUID, toString)
import Data.UUID.V4 (nextRandom)



------- Organizer ---------

type Organizer = Tree ONode

newOrganizer :: IO Organizer
newOrganizer = do
    newId <- nextRandom
    return (Node (ONode  newId "root") [])

root :: Organizer -> Organizer
root = id

children :: Organizer -> [Organizer]
children = subForest

apply :: Tree ONode -> Operation -> IO (Tree ONode)
apply (Node root children) (NewNode nl) = do
    newId <- nextRandom
    return (Node root (children ++ [Node (ONode newId nl) []]))

draw :: (Tree ONode) -> String
draw o = drawTree $ fmap internalLabel o

label :: Tree Onode -> String
label (Node n _) = label n


-------- ONode -----------

data ONode = ONode {
    nodeId      :: UUID,
    label   :: String
}

internalLabel :: ONode -> String
internalLabel n = toString (nodeId n) ++ " " ++ label n


----- Operation -----

newtype Operation = NewNode String

newNode :: String -> Operation
newNode = NewNode


