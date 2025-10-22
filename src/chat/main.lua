local socket = require("socket")
local chat_server = require("src/chat/chat_server")
local chat_info = require("src/chat/chat_info")

local server = chat_server.start()

-- chat server loop
while true do
    local readable, _, error = socket.select(chat_server.connections, nil)
    if not error then
        for _, input in ipairs(readable) do
            if input == server then
                chat_server.user_connection()
            else
                chat_server.user_input(input)
            end
        end
    else
        print(chat_info.server_loop_error(error))
        break
    end
end
