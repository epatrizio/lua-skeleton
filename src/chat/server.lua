local socket = require("socket")

local client = require("chat.client")
local messages = require("chat.messages")

local server = {}
server.connections = {}
server.users = {}

function server.start(address, port)
    -- create and bind a TCP socket
    local tcp_server = assert(socket.bind(address, port))

    table.insert(server.connections, tcp_server)

    local ip, port = tcp_server:getsockname()
    print(messages.server_start(ip, port))

    return tcp_server
end

function server.user_connection()
    local tcp_server = server.connections[1] -- hard-coded: cf. chat_server.start():table.insert server
    local tcp_client = tcp_server:accept()
    local user, error = client.login(tcp_client)
    if not error then
        table.insert(server.connections, tcp_client)
        server.users[tcp_client] = user
    else
        print("error:" .. error)
    end
end

function server.user_logout(user)
    -- clean connections
    for i, conn in ipairs(server.connections) do
        if conn == user.tcp_client then
            table.remove(server.connections, i)
            break
        end
    end
    -- clean users
    server.users[user.tcp_client] = nil
end

function server.users_list(user)
    print("connected users list request " .. user.username)
    user.tcp_client:send("connected users list: ")
    for _, u in pairs(server.users) do
        user.tcp_client:send("*" .. u.username .. "* ")
    end
    user.tcp_client:send("\n")
end

function server.user_from_username(username)
    for _, user in pairs(server.users) do
        if user.username == username then
            return user
        end
    end
    return nil, messages.invalid_username(username)
end

function server.send_msg_all(user, msg)
    for i, conn in ipairs(server.connections) do
        if i > 1 and conn ~= user.tcp_client then -- i>1: hard-coded: cf. chat_server.start():table.insert server
            client.send_msg(user, server.users[conn], msg)
        end
    end
end

function server.dispatch_action(user, msg)
    local function starts_with(str, start)
        return string.sub(str, 1, #start) == start
    end
    if starts_with(msg, "/logout") then
        client.logout(user)
        server.user_logout(user)
    elseif starts_with(msg, "/help") then
        client.help(user)
    elseif starts_with(msg, "/users") then
        server.users_list(user)
        user.tcp_client:send(messages.user_prompt(user.username))
    elseif starts_with(msg, "/msg_all") then
        local msg = string.sub(msg, 10)
        server.send_msg_all(user, msg)
        user.tcp_client:send(messages.user_prompt(user.username))
    elseif starts_with(msg, "/msg") then
        local msg = string.sub(msg, 5)
        -- pattern: /msg_*username*_"msg"
        for username, msg in string.gmatch(msg, '*(.+)* "(.+)"') do
            local user_to, error = server.user_from_username(username)
            if not error then
                client.send_msg(user, user_to, msg)
            else
                user.tcp_client:send(messages.invalid_username(username))
            end
            user.tcp_client:send(messages.user_prompt(user.username))
            break
        end
    else
        user.tcp_client:send(messages.invalid_command(msg))
        user.tcp_client:send(messages.user_prompt(user.username))
    end
end

function server.user_input(tcp_client)
    local msg, error = tcp_client:receive()
    if not error then
        local user = server.users[tcp_client]
        server.dispatch_action(user, msg)
    else
        print("error:" .. error)
    end
end

return server
