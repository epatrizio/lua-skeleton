--[[
Fibonacci
--]]

--- Fun Fibonacci function implementation
--- Hybrid: cross-calls Fibo_h <> cfibo.fibo_h
-- @module Lua_fibonacci

local cfibo = require("fibonacci_c")

function Fibo_h(n)
    if n <= 0 then
        return 0
    elseif n == 1 then
        return 1
    else
        return Fibo_h(n - 1) + cfibo.fibo_h(n - 2)
    end
end
