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

## Code examples

* `src/factorial.lua`: Lua factorial module (see build.modules section in .rockspec file for module name config)

```lua
local factorial = require("factorial")
```

* `src/factorial.c`: C Lua factorial module (idem, see build.modules section in .rockspec)
* `src/linked_list.c`: C Lua linked_list module with C pointer manipulation (idem, see build.modules section in .rockspec)

```lua
local factorial_c = require("factorial_c")
local linked_list = require("linked_list")
```

* `ext/c/main.c`: Lua embedded in a C program (see Makefile `ext_c_build` and `ext_c_run` rules)
* `ext/ocaml/`: Lua embedded in an OCaml program with [Lua bindings](https://github.com/pdonadeo/ocaml-lua)
(see Makefile `ext_ocaml_build` and `ext_ocaml_run` rules)
* [Chat app](https://github.com/epatrizio/lua-skeleton/tree/main/src/chat) #TODO

## Testing tools

Three testing approaches are implemented :

* `lua test/assert_factorial.lua -v` : *core* approach using the `assert` basic keyword
* `lua test/test_factorial.lua -v` : by using [luaunit](https://github.com/bluebird75/luaunit) framework
* `busted -v` : by using [busted](https://lunarmodules.github.io/busted/) framework
  * for code coverage generation, [luacov](https://luarocks.org/modules/lunarmodules/luacov) is needed with busted (`busted -v -c`)

`luarocks test` command launches the 3 testing approaches.
See `test.sh` file referenced in `.rockspec` file for configuration.
