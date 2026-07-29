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

#WIP

* 3 framaworks: core (assert) + luaunit + busted
* code coverage: luacov + busted (`busted -v -c`)
* `luarocks test`: see test.sh + .rockspec

## Code examples

#WIP

* factorial module (lua + C) & linked_list (C)
* lua embedded in C and in OCaml
* [Chat app](https://github.com/epatrizio/lua-skeleton/tree/main/src/chat) 
