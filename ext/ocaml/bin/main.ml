open Lua_api
open Lua_api_lib
(* open Lua_aux_lib *)

(* example of using the ocaml-lua library (https://github.com/pdonadeo/ocaml-lua)
    Nb. this OCaml code is not idiomatic. It should be in a more "functional style".
    It should be seen as a simple example
*)

let () =
  print_endline "Extending OCaml program with Lua!";

  let ls = LuaL.newstate () in
  LuaL.openlibs(ls);

  let status_l = LuaL.loadfile ls "../lua/stuff.lua" in
  let status_c = pcall ls 0 0 0 in
  if status_l != LUA_OK && status_c != LUA_OK then
    print_endline "loadfile error"
    (* TODO: LuaL.error ls format *)
  else (
    print_endline "lua file loaded!";

    print_endline "configuration loading ...";
    getglobal ls "var_1";
    getglobal ls "var_2";
    getglobal ls "var_3";
    let var_1 = tointeger ls (-3) in
      match tostring ls (-2) with
      | None -> ()
      | Some var_2 -> (
        pushstring ls "key_1";
        gettable ls (-2);
        let var_3_key_1 = tointeger ls (-1) in
        pop ls 1;
        pushstring ls "key_2";
        gettable ls (-2);
        let var_3_key_2 = tointeger ls (-1) in
        pop ls 1;
        print_endline ("conf: var_1=" ^ (string_of_int var_1));
        print_endline ("conf: var_2=" ^ var_2);
        print_endline ("conf: var_3_key_1=" ^ (string_of_int var_3_key_1));
        print_endline ("conf: var_3_key_2=" ^ (string_of_int var_3_key_2));
      );

    print_endline "hello_world lua function call ...";
    getglobal ls "hello_world";         (* TODO: isfunction ls (-1) control *)
    let _status_c = pcall ls 0 0 0 in   (* TODO: _statuc_c = LUA_OK control *)
    
    print_endline "hello lua function call ...";
    getglobal ls "hello";
    pushstring ls "earth";
    let _status_c = pcall ls 1 0 0 in

    print_endline "hello_str lua function call ...";
    getglobal ls "hello";
    pushstring ls "galaxy";
    let status_c = pcall ls 1 1 0 in
    if status_c != LUA_OK then
      print_endline "lua_pcall error"  (*TODO: tostring ls (-1) is an option type *)
    else
      match tostring ls (-1) with
      | None -> ()
      | Some s -> print_endline s

    (* LuaL.close fs - does not exist in OCaml, unlike in C *)
  )
