local messages = require("chat.messages")

local client = {}

function client.help(user)
    print("user help " .. user.username)
    user.tcp_client:send(messages.help())
    user.tcp_client:send(messages.user_prompt(user.username))
end

function client.login(tcp_client)
    tcp_client:send(messages.user_login())
    local username, err = tcp_client:receive()
    if not err then
        print("user login " .. username)
        tcp_client:settimeout(nil)
        tcp_client:setoption("keepalive", true)
        tcp_client:send(messages.user_welcome(username))
        tcp_client:send(messages.help())
        tcp_client:send(messages.user_prompt(username))
        local user = require("src/chat/user")
        return user.new(username, tcp_client)
    else
        local err_msg = "user login error:" .. err
        print(err_msg)
        tcp_client:send(err_msg .. "\n")
        tcp_client:close()
        return nil, err_msg
    end
end

function client.send_msg(user_from, user_to, msg)
    print("send msg from " .. user_from.username .. " to " .. user_to.username)
    user_to.tcp_client:send("msg from *" .. user_from.username .. "*: " .. msg .. "\n")
    user_to.tcp_client:send(messages.user_prompt(user_to.username))
end

function client.logout(user)
    print("user logout " .. user.username)
    user.tcp_client:send(messages.user_logout(user.username))
    user.tcp_client:close()
end

return client
