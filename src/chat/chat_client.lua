-- local socket = require("socket")

local chat_client = {}

local function starts_with(str, start)
   return string.sub(str, 1, #start) == start
end

function chat_client.logout(client)
    print("user logout")
    client:send("goodbye and see you soon ;)\n")
    client:close()
end

function chat_client.dispatch_action(client, msg)
    if starts_with(msg, "/logout") then
        chat_client.logout(client)
    else
        -- default, tmp: return received msg to the client
        client:send("received msg:" .. msg .. "\n")
    end
end

return chat_client
