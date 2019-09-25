-- | Description: IO implementation of the Effect interfaces.

module EffectIO where

import qualified Effect
import qualified Prelude -- import qualified to make it clearer where the functions are coming from

instance Effect.Input Prelude.IO where
  getLine = Prelude.getLine

instance Effect.Output Prelude.IO where
  putStrLn = Prelude.putStrLn
