#include "assert.h"

#include "lua.h"
#include "lauxlib.h"
#include <stdio.h>

/***
Fun Fibonacci function implementation
Hybrid: cross-calls Lua Fibo_h <> C fibo_h
@module C_fibonacci
*/

long fibo_lua(lua_State *L, long n)
{
    lua_getglobal(L, "Fibo_h");
    if (!lua_isfunction(L, -1))
        lua_error(L);
    lua_pushinteger(L, n);
    if (lua_pcall(L, 1, 1, 0) != LUA_OK) {
        printf("lua_pcall error: %s\n", lua_tostring(L, -1));
        lua_error(L);
    }
    return lua_tointeger(L, -1);
}

// Hybrid Fibonacci
long fibo_h(lua_State *L, long n)
{
    assert(n >= 0);
    if (n == 0)
        return 0;
    else {
        if (n == 1)
            return 1;
        else {
            // 1. Rec call std
            long n_1 = fibo_h(L, n - 1);
            // 2. Lua call
            long n_2 = fibo_lua(L, n - 2);
            // --
            return n_1 + n_2;
        }
    }
}

int luaF_fibo_h(lua_State *L)
{
    // if ( luaL_loadfile(L, "./fibonacci.lua") || lua_pcall(L, 0, 0, 0) )
    // if ( luaL_dofile(L, "./fibonacci.lua") )
    //     lua_error(L);
    // Not useful:
    //      local cfibo = require("fibonacci_c") in fibonacci.lua
    //      L already contains "fibonacci.fibo_h" name
    lua_Integer n = luaL_checkinteger(L, 1);
    lua_pushinteger(L, fibo_h(L, n));
    return 1;
}

static luaL_Reg const fibonacci_c_lib[] =
    {
        {"fibo_h", luaF_fibo_h},
        {NULL, NULL}};

// #ifndef FIBONACCI_C_API
// #define FIBONACCI_C_API
// #endif

// FIBONACCI_C_API luaopen_fibonacci_c(lua_State *L)
/* LUAMOD_API */ int luaopen_fibonacci_c(lua_State *L)
{
    luaL_newlib(L, fibonacci_c_lib);
    return 1;
}
