import Data.Binary (decode, decodeFile, encode, encodeFile)
import Organizer (OHorizon (None), apply, children, draw, horizon, label, newNode, newOrganizer, root)
import Test.Hspec (describe, hspec, it, shouldBe)

main :: IO ()
main = hspec $ do
    describe "Tests" $ do
        it "New child" $ do
            o <- newOrganizer
            let op = newNode "new" None
            o' <- apply o op
            putStrLn (draw o')
            let n = root ((children o') !! 0)
            (label n) `shouldBe` "new"
            (horizon n) `shouldBe` None

    describe "Serialization" $ do
        it "Back and forth" $ do
            o <- newOrganizer
            let op = newNode "new" None
            o' <- apply o op
            let o'' = decode $ encode o'
            o'' `shouldBe` o'

        it "Save and load" $ do
            o <- newOrganizer
            let op = newNode "new" None
            o' <- apply o op

            encodeFile "test.txt" $ o'
            o'' <- decodeFile "test.txt"
            o'' `shouldBe` o'
