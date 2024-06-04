{-# LANGUAGE DeriveGeneric #-}

module Document (Document (Document), OHorizon (None), root, newNode, newDocument, apply, children, label, horizon, tree) where 

import Organizer (OTree, ONode (ONode), OHorizon (None) , newOrganizer, addTopLevelNodeToTree, children, label, horizon, root)
import Tag
import Data.UUID.V4
import Data.UUID
import Data.Binary

import GHC.Generics (Generic)

----- Document -----

data Document = Document {
    organizer   :: OTree,
    tags        :: TTree

} deriving (Eq, Show, Generic)

instance Binary Document

tree :: Document -> OTree
tree = organizer

newDocument :: IO Document
newDocument = do
                    tagTreeId <- nextRandom
                    rootNodeId <- nextRandom
                    let org = newOrganizer rootNodeId
                    let tagTree = newTagTree tagTreeId
                    return (Document org tagTree)

addTopLevelNode :: Document -> ONode -> Document
addTopLevelNode doc node = 
    doc { organizer = addTopLevelNodeToTree (organizer doc) node }


----- Operation -----

data Operation = NewNode UUID String OHorizon

apply :: Document -> Operation -> Document
apply document (NewNode id label horizon) = 
    let 
        newNode = ONode id label horizon
    in
        addTopLevelNode document newNode

newNode :: String -> OHorizon -> IO Operation
newNode label horizon = do
    id <- nextRandom
    return (NewNode id label horizon)