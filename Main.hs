{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Main where


import GHC.Generics
import Data.Aeson
import Network.Wreq
import Data.Time
import Data.Text
import System.Random
import Data.Time.ISO8601 (formatISO8601Javascript)
import qualified Data.ByteString.Lazy as L

data ClientReq = ClientReq {
                   start_lat :: Double
                 , start_lon :: Double
                 , end_lat :: Double
                 , end_lon :: Double
                 , end_time :: String
                 , email :: !Text
                 , desired_price :: Double
              } deriving (Show, Generic)

instance FromJSON ClientReq
instance ToJSON ClientReq

{-
   we are going to do 500 reqs
   for the end_lat take 30.26463 and get an end that is +/- 0.1
   for the end_lon take -97.74403 and get an end that is +/- 0.1
   for the time take some time between 30 seconds from now and 5 minutes from now
   for the price use some number between 7 and 30
-}

getRandomData :: UTCTime -> IO (ClientReq)
getRandomData nowTime = do
  randomLatSeed <- randomRIO((-0.1),0.1) :: IO (Double)
  randomLonSeed <- randomRIO((-0.1),0.1) :: IO (Double)

  randomTimeSecondsSeed <- randomRIO(0,300) :: IO (Integer)

  randomPrice <- randomRIO(7,30) :: IO (Double)

  return(ClientReq {
         start_lat=(30.26463)
       , start_lon=(-97.74403)
       , end_lat=(30.26463 + randomLatSeed)
       , end_lon=((-97.74403) + randomLonSeed)
       , end_time= formatISO8601Javascript $ addUTCTime (fromIntegral randomTimeSecondsSeed) nowTime
       , email="someemail@gmail.com"
       , desired_price=randomPrice
       })

reqTarget :: String
reqTarget = "http://localhost:3000"

makeReq :: String -> ClientReq -> IO (Response L.ByteString)
makeReq target dat = post reqTarget (toJSON dat)

main :: IO ()
main = do
  nowTimeUTC <- getCurrentTime
  randomDataList <- mapM getRandomData ( Prelude.take 20 (repeat nowTimeUTC) )
  responseList <- mapM (makeReq reqTarget) randomDataList
  print responseList
  return ()
