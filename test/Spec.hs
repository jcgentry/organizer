import Data.Binary (decode, decodeFile, encode, encodeFile)
import Document 
import Test.Hspec (describe, hspec, it, shouldBe)

main :: IO ()
main = hspec $ do
    describe "Tests" $ do
        it "New child" $ do
            doc <- newDocument
            op <- newNode "new" None
            let doc' = apply doc op
            let n = root ((children (tree doc')) !! 0)
            (label n) `shouldBe` "new"
            (horizon n) `shouldBe` None

    describe "Serialization" $ do
        it "Back and forth" $ do
            doc <- newDocument
            op <- newNode "new" None
            let doc' = apply doc op
            (decode $ encode doc') `shouldBe` doc'

        it "Save and load" $ do
            doc <- newDocument
            op <- newNode "new" None
            let doc' = apply doc op

            encodeFile "test.txt" doc'
            decoded <- decodeFile "test.txt"
            decoded `shouldBe` doc'
