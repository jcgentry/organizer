module ReplTools where

import Control.Monad.State.Lazy
import Document

new :: State Document ()
new = return 