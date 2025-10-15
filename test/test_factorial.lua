local lu = require('luaunit')

local factorial = require('factorial')

function testFactImp()
    lu.assertEquals(factorial.fact_imp(0), 1)
    lu.assertEquals(factorial.fact_imp(1), 1)
    lu.assertEquals(factorial.fact_imp(5), 120)
end

function testFactRec()
    lu.assertEquals(factorial.fact_rec(0), 1)
    lu.assertEquals(factorial.fact_rec(1), 1)
    lu.assertEquals(factorial.fact_rec(5), 120)
end

function testFactEq()
    lu.assertEquals(factorial.fact_imp(10), factorial.fact_rec(10))
end

function testFactError()
    lu.assertError(factorial.fact_imp, -42)
    lu.assertError(factorial.fact_rec, -42)
end

os.exit(lu.LuaUnit.run())
