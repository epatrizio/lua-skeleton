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
