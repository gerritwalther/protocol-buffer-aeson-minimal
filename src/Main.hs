{-# LANGUAGE TemplateHaskell, OverloadedStrings #-}
module Main where

-------------------------------------------------------------------------------
-- import              Data.ByteString.Char8               as B
import              Text.ProtocolBuffers.TextMessage
import              Text.ProtocolBuffers.Basic

import              Registrant.Registrant
import              JSONModel
-------------------------------------------------------------------------------

-- jsonOptions parameter für deriveJSON muss importiert sein, daher definiert in anderem modul
$(deriveJSON jsonOptions ''Response)
$(deriveJSON jsonOptions ''Type)

-------------------------------------------------------------------------------

main :: IO ()
main = do
    let registrant = Registrant { name = Utf8 "haskell" }
        register = Response { _data = "{" ++ messagePutText registrant ++ "}"
                            , _profile = Nothing
                            , _request = "register"
                            , _type = Type { _name = "normal" }
                            }
        registerJSON = encode register

    putStrLn $ show registerJSON
