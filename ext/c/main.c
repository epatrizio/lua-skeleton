#include <stdio.h>
#include <stdlib.h>

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

int main()
{
    printf("Extending C program with Lua!\n");

    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    if (luaL_loadfile(L, "./ext/lua/stuff.lua") || lua_pcall(L, 0, 0, 0))
        lua_error(L);

    printf("lua file loaded!\n");

    printf("configuration loading ...\n");
    lua_getglobal(L, "var_1");
    lua_getglobal(L, "var_2");
    lua_getglobal(L, "var_3");
    if (!lua_isinteger(L, -3))
        lua_error(L);
    if (!lua_isstring(L, -2))
        lua_error(L);
    if (!lua_istable(L, -1))
        lua_error(L);

    int var_1 = lua_tointeger(L, -3);
    const char *var_2 = lua_tostring(L, -2);

    lua_pushstring(L, "key_1");
    lua_gettable(L, -2);
    int var_3_key_1 = lua_tointeger(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "key_2");
    lua_gettable(L, -2);
    int var_3_key_2 = lua_tointeger(L, -1);
    lua_pop(L, 1);

    printf("conf: var_1=%i\n", var_1);
    printf("conf: var_2=%s\n", var_2);
    printf("conf: var_3_key_1=%i\n", var_3_key_1);
    printf("conf: var_3_key_2=%i\n", var_3_key_2);

    printf("hello_world lua function call ...\n");
    lua_getglobal(L, "hello_world");
    if (!lua_isfunction(L, -1))
    {
        lua_error(L);
    }
    if (lua_pcall(L, 0, 0, 0) != LUA_OK)
    { // 0 arg, 0 return
        printf("lua_pcall error: %s\n", lua_tostring(L, -1));
        lua_error(L);
    }

    printf("hello lua function call ...\n");
    lua_getglobal(L, "hello");
    if (!lua_isfunction(L, -1))
    {
        lua_error(L);
    }
    lua_pushstring(L, "earth");
    if (lua_pcall(L, 1, 0, 0) != LUA_OK)
    { // 1 arg (pushstring earth), 0 return
        printf("lua_pcall error: %s\n", lua_tostring(L, -1));
        lua_error(L);
    }

    printf("hello_str lua function call ...\n");
    lua_getglobal(L, "hello_str");
    if (!lua_isfunction(L, -1))
    {
        lua_error(L);
    }
    lua_pushstring(L, "galaxy");
    if (lua_pcall(L, 1, 1, 0) != LUA_OK)
    { // 1 arg (pushstring galaxy), 1 return (isstring check)
        printf("lua_pcall error: %s\n", lua_tostring(L, -1));
        lua_error(L);
    }
    else
    {
        if (!lua_isstring(L, -1))
            printf("lua_pcall return type error: %s\n", lua_tostring(L, -1));
        else
            printf("%s\n", lua_tostring(L, -1));
        lua_pop(L, lua_gettop(L)); // pop returned value
    }

    lua_close(L);

    return EXIT_SUCCESS;
}
