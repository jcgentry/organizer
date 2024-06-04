{-# LANGUAGE DeriveGeneric #-}

module Tag (Tag, TTree, newTagTree) where

import Data.Tree
import Data.UUID
import Data.Binary
import GHC.Generics (Generic)



----- TTree -----
type TTree = Tree Tag

newTagTree :: UUID -> TTree
newTagTree id = 
    Node (Tag id "") []

----- Tag -----

data Tag = Tag {
    id  :: UUID,
    label   :: String
} deriving (Eq, Show, Generic)

instance Binary Tag

