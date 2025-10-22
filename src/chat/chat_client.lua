local chat_info = require("src/chat/chat_info")

local chat_client = {}

local function starts_with(str, start)
    return string.sub(str, 1, #start) == start
end

function chat_client.help(user)
    print("user help " .. user.username)
    user.client:send(chat_info.help())
end

function chat_client.login(client)
    client:send(chat_info.user_login())
    local username, err = client:receive()
    if not err then
        print("user login " .. username)
        client:settimeout(nil)
        client:setoption("keepalive", true)
        client:send(chat_info.user_welcome(username))
        client:send(chat_info.help())
        client:send(chat_info.user_prompt(username))
        local user = require("src/chat/user")
        return user.new(username, client)
    else
        local err_msg = "user login error:" .. err
        print(err_msg)
        client:send(err_msg .. "\n")
        client:close()
        return nil, err_msg
    end
end

function chat_client.logout(user)
    print("user logout " .. user.username)
    user.client:send(chat_info.user_logout(user.username))
    user.client:close()
end

function chat_client.dispatch_action(user, msg)
    if starts_with(msg, "/logout") then
        chat_client.logout(user)
    elseif starts_with(msg, "/help") then
        chat_client.help(user)
        user.client:send(chat_info.user_prompt(user.username))
    else
        -- default, tmp: return received msg to the client
        user.client:send("received msg:" .. msg .. "\n")
        user.client:send(chat_info.user_prompt(user.username))
    end
end

return chat_client
