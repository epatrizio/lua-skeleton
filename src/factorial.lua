--[[
Minimal factorial module
--]]

--- Different factorial function implementation
-- @module Lua_factorial

local factorial = {}

--- module version 1.1
factorial._VERSION = "1.1"

local function is_integer(n)
    return type(n) == "number" and math.floor(n) == n
end

--- 1: Basic imperative version
--- @function factorial.fact_imp
-- @param int factorial number to compute
-- @return factorial result
function factorial.fact_imp(n)
    if not is_integer(n) then
        error("factorial.fact_imp error: number must be an integer", 1)
        -- , 1 (default error level) -- 2 (up, for call information)
    end
    assert(n >= 0, "number must be positive")
    local f = 1
    for i = 1, n do
        f = f * i
    end
    return f
end

--- 2: Standard recursive version
--- @function factorial.fact_rec
-- @param int factorial number to compute
-- @return factorial result
function factorial.fact_rec(n)
    if not is_integer(n) then
        -- an arror can be of all types
        error({ func = "factorial.fact_rec", msg = "number must be an integer" }, 2)
    end
    assert(n >= 0, "number must be positive")
    if n <= 0 then
        return 1
    else
        return n * factorial.fact_rec(n - 1)
    end
end

local function Fact_continuation(f_cont, n)
    -- NB. no 'n' validity checks here (same, see imp and rec version)
    if n == 0 then
        return f_cont(1)
    else
        return Fact_continuation(function (x) return f_cont(n * x) end, n - 1)
    end
end

--- 3: CPS (Continuation Passing Style) version
--- @function factorial.fact_cont
-- @param int factorial number to compute
-- @return factorial result
function factorial.fact_cont(n)
    return Fact_continuation(function (x) return x end, n)
end

-- NB. idem, no 'n' validity checks here (same, see imp and rec version)
local function I_Gen()
    local i = 0
    while true do
        i = i + 1
        coroutine.yield(i)
    end
end

--- 4: Coroutine version
--- @function factorial.fact_co
-- @param int factorial number to compute
-- @return factorial result
function factorial.fact_co(n)
    local i_gen = coroutine.create(I_Gen)
    local status, i, f = true, 1, 1
    while status and i <= n do
        f = f * i
        status, i = coroutine.resume(i_gen)
    end
    return f
end

return factorial
