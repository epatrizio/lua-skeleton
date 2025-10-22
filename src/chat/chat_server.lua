local socket = require("socket")
local chat_client = require("src/chat/chat_client")
local chat_info = require("src/chat/chat_info")

local chat_server = {}

chat_server.connections = {}

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

    chat_client.login(client)

    table.insert(chat_server.connections, client)
end

function chat_server.user_input(client)
    print("user input")

    local msg, err = client:receive()
    if not err then
        chat_client.dispatch_action(client, msg)
    else
        print("error:" .. err)
    end
end

return chat_server
