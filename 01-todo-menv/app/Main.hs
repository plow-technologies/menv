module Main where

import           EffectIO () -- get IO implementation of effect interface
import qualified Library

main :: IO ()
main = Library.main
