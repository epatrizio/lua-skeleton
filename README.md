# lua-skeleton - a full example

I'm on my journey to learn the [Lua programming language](https://www.lua.org).
Alongside `ola`, a [Lua interpreter written in OCaml](https://github.com/epatrizio/ola),
here is a complete example of a (toy) application. Complete in the sense that:

* Development stack implementation (tools chain)
* Testing tool experimentations (different frameworks)
* Multiple code examples (Lua modules in Lua and C, toy *chat app*)

## Development stack

* [LuaRocks](https://luarocks.org) is the package manager for Lua modules
  * `lua-skeleton-0.1-1.rockspec`: configuration file
  * `luarocks build`: main command (dependencies install, C custom module compilation, local deployment)
    * `eval "$(luarocks path --bin)"`: command terminal initialization
* Documentation
  * Source code documentation: [LDoc, a Lua Documentation Tool](https://lunarmodules.github.io/ldoc/manual/manual.md.html)
    * `ldoc -d doc/src src`: main command
  * Code coverage: see *Testing tools* for more details
  * `luarocks doc lua-skeleton`: open ./doc directory in a browser
  * `luarocks doc --home lua-skeleton`: open *homepage* (specified in .rockspec) in a browser
* Testing tools: focus below

## Testing tools

Three testing approaches are implemented :

* `lua test/assert_factorial.lua -v` : *core* approach using the `assert` basic keyword
* `lua test/test_factorial.lua -v` : by using [luaunit](https://github.com/bluebird75/luaunit) framework
* `busted -v` : by using [busted](https://lunarmodules.github.io/busted/) framework
  * for code coverage generation, [luacov](https://luarocks.org/modules/lunarmodules/luacov) is needed with busted (`busted -v -c`)

`luarocks test` command launches the 3 testing approaches.
See `test.sh` file referenced in `.rockspec` file for configuration.

## Code examples

#WIP

* factorial module (lua + C) & linked_list (C)
* lua embedded in C and in OCaml
* [Chat app](https://github.com/epatrizio/lua-skeleton/tree/main/src/chat) 
