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

function chat_server.user_input(client)
    local msg, error = client:receive()
    if not error then
        local user = chat_server.users[client]
        chat_client.dispatch_action(user, msg)
    else
        print("error:" .. error)
    end
end

return chat_server
