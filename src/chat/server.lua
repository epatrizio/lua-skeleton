local socket = require("socket")

local connections = {}

-- create and bind a TCP socket
local server = assert(socket.bind("*", 1234))
table.insert(connections, server)

local ip, port = server:getsockname()
print("server up! telnet listening to " .. ip .. ":" .. port)

-- server infinite loop
while true do
    local readable, _, error = socket.select(connections, nil)
    for _, input in ipairs(readable) do
        if input == server then
            print("New connection ...")
            local client = server:accept()
            client:settimeout(nil)
            client:setoption("keepalive", true)
            table.insert(connections, client)
        else
            print("New client input ...")
            local msg, err = input:receive()
            if not err then
                -- basic: return received msg to the client
                input:send("received msg:" .. msg .. "\n")
            else
                print("error:" .. err)
            end
        end
    end
end
