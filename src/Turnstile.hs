module Turnstile where

import Control.Monad

data TurnstileState = Locked | Unlocked
    deriving (Eq, Show)

data TurnstileOutput = Thank | Open | Tut
    deriving (Eq, Show)

coin, push :: TurnstileState -> (TurnstileOutput, TurnstileState)
coin _ = (Thank, Unlocked)
push Unlocked = (Open, Locked)
push Locked = (Tut, Locked)

monday :: TurnstileState -> ([TurnstileOutput], TurnstileState)
monday s0 =
    let (a1, s1) = coin s0
        (a2, s2) = push s1
        (a3, s3) = push s2
        (a4, s4) = coin s3
        (a5, s5) = push s4
     in ([a1, a2, a3, a4, a5], s5)

tuesday :: TurnstileState -> ([TurnstileOutput], TurnstileState)
tuesday s0 =
    let (a1, s1) = regularPerson s0
        (a2, s2) = hastyPerson s1
        (a3, s3) = distractedPerson s2
        (a4, s4) = hastyPerson s3
     in (a1 ++ a2 ++ a3 ++ a4, s4)

regularPerson, distractedPerson, hastyPerson :: TurnstileState -> ([TurnstileOutput], TurnstileState)

regularPerson s = 
    let 
        (o1, s1) = coin s
        (o2, s2) = push s1
    in ([o1, o2], s2)

distractedPerson s = 
    let 
        (o1, s1) = coin s
    in ([o1], s1)

hastyPerson s = 
    let 
        (o1, s1) = push s
    in
        if o1 == Open then ([o1], s1)
        else let
                (os, s2) = regularPerson s1
            in ([o1] ++ os, s2)

luckyPair :: Bool -> TurnstileState -> (Bool, TurnstileState)
luckyPair p s =
    let
        (o1, s1) = (if p then regularPerson else distractedPerson) s
        (o2, s2) = hastyPerson s1
    in ((o2 !! 0 == Open), s2)

newtype State s a = State { runState :: s -> (a, s) }

state :: (s -> (a, s)) -> State s a
state = State

instance Functor (State s) where
    fmap = liftM

instance Applicative (State s) where
    pure = return
    (<*>) = ap

instance Monad (State s) where
    return x = State ( \ s -> (x, s))

    p >>= k = state $ \ s0 -> 
        let (x, s1) = runState p s0
        in (runState (k x) s1)
                    
                            
coinS, pushS :: State TurnstileState TurnstileOutput

coinS = State coin
pushS = State push

mondayS :: State TurnstileState [TurnstileOutput]
mondayS = sequence [coinS, pushS, pushS, coinS, coinS]

regularPersonS, distractedPersonS, hastyPersonS :: State TurnstileState [TurnstileOutput]
regularPersonS = sequence [coinS, pushS] 

distractedPersonS = sequence [coinS]

hastyPersonS = sequence [pushS]