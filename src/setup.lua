--[[
https://martin-fieber.de/blog/lua-project-setup-with-luarocks/#resolve-module-paths

- Very useful for path configuration in a luarocks use context
- To launch the VSCode debugger, 'require setup' must be added at the beginning of the file to be debugged
--]]

local version = _VERSION:match("%d+%.%d+")

local luarocks_path = "/home/epatrizio/.luarocks/share/lua/"
local lua_path = luarocks_path .. version .. "/?.lua;" .. luarocks_path .. version .. "/?/init.lua"

local luarocks_cpath = "/home/epatrizio/.luarocks/lib/lua/"
local lua_cpath = luarocks_cpath .. version .. "/?.so"

package.path = lua_path .. ";" .. package.path
package.cpath = lua_cpath .. ";" .. package.cpath
