local socket = require("socket")
local chat_client = require("src/chat/chat_client")

local chat_server = {}

chat_server.connections = {}

function chat_server.info()
    return "chat_server.info(): to be implemented!\n"
end

function chat_server.start()
    -- create and bind a TCP socket
    local server = assert(socket.bind("*", 1234))

    table.insert(chat_server.connections, server)

    local ip, port = server:getsockname()
    print("chat server up! telnet listening to " .. ip .. ":" .. port)

    return server
end

function chat_server.user_connection()
    print("user connection")

    local server = chat_server.connections[1] -- hard-coded: cf. chat_server.start():table.insert server
    local client = server:accept()
    client:settimeout(nil)
    client:setoption("keepalive", true)

    table.insert(chat_server.connections, client)

    client:send(chat_server.info())
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
