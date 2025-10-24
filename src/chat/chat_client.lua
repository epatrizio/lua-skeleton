local chat_info = require("src/chat/chat_info")

local chat_client = {}

function chat_client.help(user)
    print("user help " .. user.username)
    user.client:send(chat_info.help())
    user.client:send(chat_info.user_prompt(user.username))
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

function chat_client.send_msg(user_from, user_to, msg)
    print("send msg from " .. user_from.username .. " to " .. user_to.username)
    user_to.client:send("msg from *" .. user_from.username .. "*: " .. msg .. "\n")
    user_to.client:send(chat_info.user_prompt(user_to.username))
end

function chat_client.logout(user)
    print("user logout " .. user.username)
    user.client:send(chat_info.user_logout(user.username))
    user.client:close()
end

return chat_client
