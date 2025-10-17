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

static const struct luaL_Reg functions[] = {
    {"fact_imp", lua_fact_imp},
    {"fact_rec", lua_fact_rec},
    {NULL, NULL}};

static luaL_Reg const factorial_c_lib[] =
    {
        {"fact_imp", lua_fact_imp},
        {"fact_rec", lua_fact_rec},
        {0, 0}};

#ifndef FACTORIAL_C_API
#define FACTORIAL_C_API
#endif

FACTORIAL_C_API luaopen_factorial_c(lua_State *L)
{
    luaL_newlib(L, factorial_c_lib);
    return 1;
}
