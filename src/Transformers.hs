module Transformers where
import Data.Char
import Main (main)

getPassphrase :: IO (Maybe String)
getPassphrase = do
    s <- getLine
    if isValid s
    then return $ Just s
    else return Nothing

-- The validation test could be anything we want it to be.
isValid :: String -> Bool
isValid s = length s >= 8
                && any isAlpha s
                && any isNumber s
                && any isPunctuation s

askPassphrase :: IO ()
askPassphrase = do putStrLn "Insert your new passphrase:"
                   maybe_value <- getPassphrase
                   case maybe_value of
                       Just value -> do putStrLn "Storing in database..."  -- do stuff
                       Nothing -> putStrLn "Passphrase invalid."

newtype MaybeT m a = MaybeT { runMaybeT :: m (Maybe a)}

instance Monad m => Monad (MaybeT m) where
    return = MaybeT . return . Just

    -- The signature of (>>=), specialized to MaybeT m:
    -- (>>=) :: MaybeT m a -> (a -> MaybeT m b) -> MaybeT m b
    (>>=) (MaybeT monadMaybeA) aReturnMaybeTMB =
        MaybeT $ do
            maybeA <- monadMaybeA
            case maybeA of
                Nothing -> return Nothing
                Just a -> aReturnMaybeTMB a