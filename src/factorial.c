#include "assert.h"

#include "lua.h"
#include "lauxlib.h"

long fact_imp(long n)
{
    assert(n >= 0);

    long fact = 1;
    for (long i = 1; i <= n; i++)
        fact = fact * i;

    return fact;
}

long fact_rec(long n)
{
    assert(n >= 0);

    if (n == 0)
        return 1;
    else
        return n * fact_rec(n - 1);
}

int lua_fact_imp(lua_State *L)
{
    lua_Integer n = luaL_checkinteger(L, 1);
    lua_pushinteger(L, fact_imp(n));
    return 1;
}

int lua_fact_rec(lua_State *L)
{
    lua_Integer n = luaL_checkinteger(L, 1);
    lua_pushinteger(L, fact_rec(n));
    return 1;
}

static luaL_Reg const factorial_c_lib[] =
    {
        {"fact_imp", lua_fact_imp},
        {"fact_rec", lua_fact_rec},     // function
        {"_VERSION", NULL},             // constant: see luaopen_factorial_c
        {NULL, NULL}};

// #ifndef FACTORIAL_C_API
// #define FACTORIAL_C_API
// #endif

// luaopen_**factorial_c** > require("factorial_c")
// FACTORIAL_C_API luaopen_factorial_c(lua_State *L)
LUAMOD_API int luaopen_factorial_c(lua_State *L)
{
    luaL_newlib(L, factorial_c_lib);
    lua_pushstring(L, "1.0");
    lua_setfield(L, -2, "_VERSION");
    return 1;
}
