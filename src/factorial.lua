--[[
Minimal factorial module
--]]

local factorial = {}

factorial._VERSION = "1.0"

local function is_integer(n)
    return type(n) == "number" and math.floor(n) == n
end

-- 1: Basic imperative version
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

-- 2: Standard recursive version
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

return factorial
