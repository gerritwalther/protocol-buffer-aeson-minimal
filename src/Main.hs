{-# LANGUAGE TemplateHaskell, OverloadedStrings #-}
module Main where

-------------------------------------------------------------------------------
-- import              Data.ByteString.Char8               as B
import              Text.ProtocolBuffers.TextMessage
import              Text.ProtocolBuffers.Basic

import              Registrant.Registrant
import              JSONModel

import Data.Aeson ((.=))
import qualified Data.Aeson as J
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as BCL
import qualified Data.Text.Encoding as T
-------------------------------------------------------------------------------

-- jsonOptions parameter für deriveJSON muss importiert sein, daher definiert in anderem modul
$(deriveJSON jsonOptions ''Response)
$(deriveJSON jsonOptions ''Type)

-------------------------------------------------------------------------------

instance ToJSON Registrant where
    toJSON registrant =
        J.object ["name" .= name registrant]

instance ToJSON Utf8 where
    toJSON u = J.String (T.decodeUtf8 (BL.toStrict  (utf8 u)))

main :: IO ()
main = do
    let registrant = Registrant { name = Utf8 "haskell" }
        register = Response { _data = BCL.unpack (J.encode registrant)
                            , _profile = Nothing
                            , _request = "register"
                            , _type = Type { _name = "normal" }
                            }
        registerJSON = encode register

    putStrLn $ BCL.unpack registerJSON
