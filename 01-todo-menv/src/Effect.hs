-- | Description: The effect interface expressed as type classes.

{-# LANGUAGE ConstraintKinds #-} -- allows us to combine constraints using a type synonym

module Effect where

class Monad m => Input m where
  getLine :: m String

class Monad m => Output m where
  putStrLn :: String -> m ()

-- | Combined 'Input' and 'Output'
type InputOutput m = (Input m, Output m)
