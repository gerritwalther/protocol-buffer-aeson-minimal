module JSONModel
  ( module JSONModel
  ) where

-------------------------------------------------------------------------------
import Data.Text                  (Text)
import Data.Aeson    as JSONModel (FromJSON, ToJSON, encode, decode')
import Data.Aeson.TH as JSONModel (Options (..), SumEncoding (..), deriveJSON)
-------------------------------------------------------------------------------

data Response = Response { _data    :: String
                         , _profile :: Maybe Text
                         , _request :: Text
                         , _type    :: Type
                         }
  deriving (Show)

data Type = Type { _name :: Text }
  deriving (Show)

-------------------------------------------------------------------------------

jsonOptions :: Options
jsonOptions = Options { fieldLabelModifier      = tail -- um den _ zu entfernen
                      , constructorTagModifier  = id
                      , allNullaryToStringTag   = True
                      , omitNothingFields       = False
                      , sumEncoding             = ObjectWithSingleField
                      }
