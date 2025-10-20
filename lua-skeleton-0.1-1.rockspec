rockspec_format = "3.0"
package = "lua-skeleton"
version = "0.1-1"
source = {
   url = "https://github.com/epatrizio/lua-skeleton.git"
}
description = {
	summary = "A Lua skeleton",
	detailed =
	[[
		A Lua language skeleton: ...
	]],
	homepage = "https://github.com/epatrizio/lua-skeleton",
	license = "The Unlicense",
	maintainer = "Eric Patrizio <epatrizio at mpns dot fr>",
}
dependencies = {
   "lua >= 5.1, < 5.5",
   "luasocket >= 3.1",
}
build = {
   type = "builtin",
   modules =
	{
		factorial = "src/factorial.lua",
		factorial_c = "src/factorial.c",
	},
	copy_directories = { "doc", "test" }
}
test = {
   type = "command",
   -- script = "test/test_factorial.lua",	-- luaunit
   script = "spec/factorial_spec.lua",		-- busted
}
test_dependencies = {
   "lua >= 5.1, < 5.5",
   "luaunit >= 3.4",
   "busted >= 2.2",
}
