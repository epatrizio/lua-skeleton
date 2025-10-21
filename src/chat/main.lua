local socket = require("socket")
local chat_server = require("src/chat/chat_server")

local server = chat_server.start()

-- chat server loop
while true do
    local readable, _, error = socket.select(chat_server.connections, nil)
    for _, input in ipairs(readable) do
        if input == server then
            chat_server.user_connection()
        else
            chat_server.user_input(input)
        end
    end
end
