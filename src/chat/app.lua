local socket = require("socket")

local server = require("chat.server")
local messages = require("chat.messages")

require("chat.setup")

local address = _G.Server_address
local port = _G.Server_port

-- command line args - https://www.lua.org/manual/5.4/manual.html#7
if arg[1] then address = arg[1] end
if arg[2] then port = tonumber(arg[2]) end

local tcp_server = server.start(address, port)

-- chat server loop
while true do
    local readable, _, error = socket.select(server.connections, nil)
    if not error then
        for _, input in ipairs(readable) do
            if input == tcp_server then
                server.user_connection()
            else
                server.user_input(input)
            end
        end
    else
        print(messages.server_loop_error(error))
        break
    end
end
