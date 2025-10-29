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
	issues_url = "https://github.com/epatrizio/lua-skeleton/issues",
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
		linked_list = "src/linked_list.c",
		["chat.client"] = "src/chat/client.lua",
		["chat.messages"] = "src/chat/messages.lua",
		["chat.server"] = "src/chat/server.lua",
		["chat.user"] = "src/chat/user.lua"
	},
	copy_directories = { "doc", "spec", "test" },
	install = {
        bin = {
            chat_app = "src/chat/app.lua"
        }
    },
}
test = {
    type = "command",
    command = "./test.sh",					-- .sh file: test suite calls
    -- script = "test/test_factorial.lua",	-- luaunit
    -- script = "spec/factorial_spec.lua",	-- busted
}
test_dependencies = {
    "lua >= 5.1, < 5.5",
    "luaunit >= 3.4",
    "busted >= 2.2",
}
