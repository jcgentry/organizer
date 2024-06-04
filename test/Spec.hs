import Data.Binary (encode, decode, encodeFile, decodeFile)
import Organizer (newOrganizer, newNode, apply, draw, children, root, label)
import Test.Hspec (hspec, describe, shouldBe, it)

main :: IO ()
main = hspec $ do
    describe "Tests" $ do
        it "New child" $ do
            o <- newOrganizer
            let op = newNode "new"
            o' <- apply o op
            putStrLn (draw o')
            let n = root ((children o') !! 0)
            (label n) `shouldBe` "new"

    describe "Serialization" $ do
        it "Back and forth" $ do
            o <- newOrganizer
            let op = newNode "new"
            o' <- apply o op
            let o'' = decode $ encode o'
            o'' `shouldBe` o'
            
        it "Save and load" $ do
            o <- newOrganizer
            let op = newNode "new"
            o' <- apply o op

            encodeFile "test.txt" $ o'
            o'' <- decodeFile "test.txt"
            o'' `shouldBe` o'
