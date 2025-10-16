--[[
Minimal factorial module
--]]

local factorial = {}

factorial._VERSION = "1.0"

-- 1: Basic imperative version
function factorial.fact_imp(n)
  assert(n >= 0, "number must be positive")
  local f = 1
  for i = 1, n do
    f = f * i
  end
  return f
end

-- 2: Standard recursive version
function factorial.fact_rec(n)
  assert(n >= 0, "number must be positive")
  if n <= 0 then
    return 1
  else
    return n * factorial.fact_rec(n - 1)
  end
end

return factorial
