local chat_info = require("src/chat/chat_info")

local chat_client = {}

local function starts_with(str, start)
   return string.sub(str, 1, #start) == start
end

function chat_client.help(client)
    print("user help")
    client:send(chat_info.help())
end

function chat_client.login(client)
    print("user login")
    client:settimeout(nil)
    client:setoption("keepalive", true)
    client:send(chat_info.user_login("username_tmp"))   -- TODO
    client:send(chat_info.help())
end

function chat_client.logout(client)
    print("user logout")
    client:send(chat_info.user_logout())
    client:close()
end

function chat_client.dispatch_action(client, msg)
    if starts_with(msg, "/logout") then
        chat_client.logout(client)
    elseif starts_with(msg, "/help") then
        chat_client.help(client)
    else
        -- default, tmp: return received msg to the client
        client:send("received msg:" .. msg .. "\n")
    end
end

return chat_client
