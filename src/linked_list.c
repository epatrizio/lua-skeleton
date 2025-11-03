#include <stdio.h>
#include <stdlib.h>

#include "lua.h"
#include "lauxlib.h"

typedef struct node
{
    int value;
    struct node *next;
} Node;

// >> not needed, reimplemented in lua_create function
// Node *list_create()
// {
//     return NULL;
// }

// >> not needed, reimplemented in lua_push_value function
// >> malloc > lua_newuserdata
// Node *list_push(int val, Node *list)
// {
//     Node *n = malloc(sizeof(Node));
//     n->value = val;
//     n->next = list;
//     return n;
// }

long list_size(Node *list)
{
    long len = 0;
    Node *current = list;
    while (current != NULL)
    {
        len++;
        current = current->next;
    }

    return len;
}

// >> not useful, and no reimplementation
// >> no malloc (see list_push) > no free!
// void list_free(Node *list)
// {
//     Node *current_node = list;
//     while (current_node != NULL)
//     {
//         Node *next_node = current_node->next;
//         free(current_node);
//         current_node = next_node;
//     }
// }

void list_print(Node *list)
{
    Node *current = list;
    while (current != NULL)
    {
        printf("%i ", current->value);
        current = current->next;
    };

    printf("\n");
}

int lua_create(lua_State *L)
{
    lua_pushnil(L);
    return 1;
}

int lua_push_value(lua_State *L)
{
    lua_Integer val = luaL_checkinteger(L, 1);
    Node *ll = (Node *)lua_touserdata(L, 2);
    Node *n = (Node *)lua_newuserdata(L, sizeof(Node));
    n->value = val;
    n->next = ll;
    return 1;
}

int lua_pop_value(lua_State *L)
{
    Node *ll = (Node *)lua_touserdata(L, 1);
    lua_pushlightuserdata(L, ll->next);     // TODO: OK ? (check: test not stable)
    lua_pushinteger(L, ll->value);
    return 2;       // in lua, 2 return values: a, b = f()
}

int lua_size(lua_State *L)
{
    Node *ll = (Node *)lua_touserdata(L, 1);
    lua_pushinteger(L, list_size(ll));
    return 1;
}

int lua_print(lua_State *L)
{
    Node *ll = (Node *)lua_touserdata(L, 1);
    list_print(ll);
    return 1;
}

static luaL_Reg const linked_list_lib[] =
    {
        {"create", lua_create},
        {"push", lua_push_value},
        {"pop", lua_pop_value},
        {"size", lua_size},
        {"print", lua_print},
        {0, 0}};

#ifndef LINKED_LIST_API
#define LINKED_LIST_API
#endif

LINKED_LIST_API luaopen_linked_list(lua_State *L)
{
    luaL_newlib(L, linked_list_lib);
    return 1;
}
