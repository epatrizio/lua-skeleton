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
}
build = {
   type = "builtin",
   modules =
	{
		factorial = "src/factorial.lua"
	},
	copy_directories = { "doc", "test" }
}
test = {
   type = "command",
   script = "test/test_factorial.lua",
}
test_dependencies = {
   "lua >= 5.1, < 5.5",
   "luaunit >= 3.4",
}
