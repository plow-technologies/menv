# TODO program - menv version

## Summary
* The effect interface is defined in [Effect.hs](./src/Effect.hs).
* The implemention for `IO` is in [EffectIO.hs](./src/EffectIO.hs).

## Diff of `Library.hs`
```bash
$ diff 01-todo-io/src/Library.hs 01-todo-menv/src/Library.hs 
```

```diff
5,6c5
< putTodo :: (Int, String) -> IO ()
< putTodo (n, todo) = putStrLn (show n ++ ": " ++ todo)
---
> import qualified Effect
8c7,10
< prompt :: [String] -> IO ()
---
> putTodo :: Effect.Output m => (Int, String) -> m ()
> putTodo (n, todo) = Effect.putStrLn (show n ++ ": " ++ todo)
> 
> prompt :: Effect.InputOutput m => [String] -> m ()
10,11c12,13
<   putStrLn ""
<   putStrLn "Current TODO list:"
---
>   Effect.putStrLn ""
>   Effect.putStrLn "Current TODO list:"
13c15
<   command <- getLine
---
>   command <- Effect.getLine
16c18
< interpret :: String -> [String] -> IO ()
---
> interpret :: Effect.InputOutput m => String -> [String] -> m ()
21c23
<       putStrLn "No TODO entry matches the given number"
---
>       Effect.putStrLn "No TODO entry matches the given number"
26c28
<   putStrLn ("Invalid command: `" ++ command ++ "`")
---
>   Effect.putStrLn ("Invalid command: `" ++ command ++ "`")
35a38
> main :: Effect.InputOutput m => m ()
37,40c40,43
<   putStrLn "Commands:"
<   putStrLn "+ <String> - Add a TODO entry"
<   putStrLn "- <Int>    - Delete the numbered entry"
<   putStrLn "q          - Quit"
---
>   Effect.putStrLn "Commands:"
>   Effect.putStrLn "+ <String> - Add a TODO entry"
>   Effect.putStrLn "- <Int>    - Delete the numbered entry"
>   Effect.putStrLn "q          - Quit"
```

## Diff of `Main.hs`
```bash
$ diff 01-todo-io/app/Main.hs 01-todo-menv/app/Main.hs
```

```diff
2a3
> import           EffectIO () -- get IO implementation of effect interface
```
