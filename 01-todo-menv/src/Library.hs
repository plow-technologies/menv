-- Adapted from http://www.haskellforall.com/2015/10/basic-haskell-examples.html

module Library where

import qualified Effect

putTodo :: Effect.Output m => (Int, String) -> m ()
putTodo (n, todo) = Effect.putStrLn (show n ++ ": " ++ todo)

prompt :: Effect.InputOutput m => [String] -> m ()
prompt todos = do
  Effect.putStrLn ""
  Effect.putStrLn "Current TODO list:"
  mapM_ putTodo (zip [0..] todos)
  command <- Effect.getLine
  interpret command todos

interpret :: Effect.InputOutput m => String -> [String] -> m ()
interpret ('+' : ' ' : todo) todos = prompt (todo : todos)
interpret ('-' : ' ' : num) todos =
  case delete (read num) todos of
    Nothing -> do
      Effect.putStrLn "No TODO entry matches the given number"
      prompt todos
    Just todos' -> prompt todos'
interpret "q" todos = return ()
interpret command todos = do
  Effect.putStrLn ("Invalid command: `" ++ command ++ "`")
  prompt todos

delete :: Int -> [a] -> Maybe [a]
delete 0 (_ : as) = Just as
delete n (a : as) = do
  as' <- delete (n - 1) as
  return (a : as')
delete _  []    = Nothing

main :: Effect.InputOutput m => m ()
main = do
  Effect.putStrLn "Commands:"
  Effect.putStrLn "+ <String> - Add a TODO entry"
  Effect.putStrLn "- <Int>    - Delete the numbered entry"
  Effect.putStrLn "q          - Quit"
  prompt []
