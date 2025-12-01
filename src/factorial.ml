open Lua_api
open Lua_api_lib
open Lua_aux_lib

let rec fact n =
  assert (n >= 0);
  match n with
  | 0 -> 1
  | n -> n * fact (n-1)

let lua_fact (ls : state) =
  let n = LuaL.checkinteger ls 1 in
  pushinteger ls (fact n);
  1

let luaopen_factorial_ml (ls : state) =
  LuaL.newmetatable ls "factorial_ml" |> ignore;
  pushocamlfunction ls lua_fact;
  setglobal ls "fact"
