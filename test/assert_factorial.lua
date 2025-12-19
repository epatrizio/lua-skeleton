local factorial = require("factorial")

io.write("Imperative factorial implementation ... ")
assert(factorial.fact_imp(0) == 1)
assert(factorial.fact_imp(1) == 1)
assert(factorial.fact_imp(5) == 120)
print("Ok")

io.write("Recursive factorial implementation ... ")
assert(factorial.fact_rec(0) == 1)
assert(factorial.fact_rec(1) == 1)
assert(factorial.fact_rec(5) == 120)
print("Ok")

io.write("Equality between imperative and recursive implementations ... ")
assert(factorial.fact_imp(10) == factorial.fact_rec(10), "ko!")
print("Ok")

io.write("Error checking for negative argument ... ")
if pcall(factorial.fact_imp, -42) then assert(false) end
if pcall(factorial.fact_rec, -42) then assert(false) end
print("Ok")

io.write("Error checking for non integer argument ... ")
if pcall(factorial.fact_imp, "incorrect") then assert(false) end
if pcall(factorial.fact_imp, false) then assert(false) end
if pcall(factorial.fact_rec, "incorrect") then assert(false) end
if pcall(factorial.fact_rec, false) then assert(false) end
print("Ok")

-- pcall/xpcall examples in a non test context

local function handle_error(err)
    if err == "<unknown>" then
        return "Unknown error!"
    else
        return err.func .. ":" .. err.msg
    end
end

local status, result = pcall(factorial.fact_imp, "incorrect")
if status then
    print(result)
else
    print("Error: ", result)
end

status, result = xpcall(factorial.fact_rec, handle_error, "incorrect")
if status then
    print(result)
else
    print("Error: ", result)
end
