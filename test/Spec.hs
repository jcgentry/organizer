import Organizer (newOrganizer, newNode, apply, draw, children, root, label)
import Test.Hspec (hspec, describe, shouldBe, it)

main :: IO ()
main = hspec $ do
    describe "Tests" $ do
        it "Trivia" $ do
            o <- newOrganizer
            let op = newNode "new"
            o' <- apply o op
            putStrLn (draw o')
            let n = root ((children o') !! 0)
            (label n) `shouldBe` "new"