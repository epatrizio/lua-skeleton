local socket = require("socket")
local chat_client = require("src/chat/chat_client")
local chat_info = require("src/chat/chat_info")

local chat_server = {}

chat_server.connections = {}
chat_server.users = {}

function chat_server.start()
    -- create and bind a TCP socket
    local server = assert(socket.bind("*", 1234))

    table.insert(chat_server.connections, server)

    local ip, port = server:getsockname()
    print(chat_info.server_start(ip, port))

    return server
end

function chat_server.user_connection()
    local server = chat_server.connections[1] -- hard-coded: cf. chat_server.start():table.insert server
    local client = server:accept()
    local user, error = chat_client.login(client)
    if not error then
        table.insert(chat_server.connections, client)
        chat_server.users[client] = user
    else
        print("error:" .. error)
    end
end

function chat_server.user_logout(user)
    -- clean connections
    for i, conn in ipairs(chat_server.connections) do
        if conn == user.client  then
            table.remove(chat_server.connections, i)
            break
        end
    end
    -- clean users
    chat_server.users[user.client] = nil
end

function chat_server.users_list(user)
    print("connected users list request " .. user.username)
    user.client:send("connected users list: ")
    for _, u in pairs(chat_server.users) do
        user.client:send("*" .. u.username .. "* ")
    end
    user.client:send("\n")
end

function chat_server.dispatch_action(user, msg)
    local function starts_with(str, start)
        return string.sub(str, 1, #start) == start
    end
    if starts_with(msg, "/logout") then
        chat_client.logout(user)
        chat_server.user_logout(user)
    elseif starts_with(msg, "/help") then
        chat_client.help(user)
        user.client:send(chat_info.user_prompt(user.username))
    elseif starts_with(msg, "/users") then
        chat_server.users_list(user)
        user.client:send(chat_info.user_prompt(user.username))
    else
        -- default, tmp: return received msg to the client
        user.client:send("received msg:" .. msg .. "\n")
        user.client:send(chat_info.user_prompt(user.username))
    end
end

function chat_server.user_input(client)
    local msg, error = client:receive()
    if not error then
        local user = chat_server.users[client]
        chat_server.dispatch_action(user, msg)
    else
        print("error:" .. error)
    end
end

return chat_server
