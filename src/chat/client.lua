local sha1 = require("sha1")

local messages = require("chat.messages")

local client = {}

local function user_exists(users, username)
    for _, user in pairs(users) do
        if user.username == username then
            return true
        end
    end
    return false
end

local function user_password(username, password)
    local pwd_sha1 = sha1.sha1(password)
    for line in io.lines(_G.Users_file) do
        local i1, _ = string.find(line, username .. ":")
        local i2, _ = string.find(line, ":" .. pwd_sha1)
        if i1 ~= nil and i1 > 0 and i2 ~= nil and i2 > 0 then
            return true
        end
    end
    return false
end

function client.help(user)
    print("user help " .. user.username)
    user.tcp_client:send(messages.help())
    user.tcp_client:send(messages.user_prompt(user.username))
end

function client.login(tcp_client, users)
    local error = function (msg)
        local err_msg = "user login error: " .. msg
        print(err_msg)
        tcp_client:send(err_msg)
        tcp_client:close()
        return err_msg
    end
    tcp_client:send(messages.user_login())
    local username, err = tcp_client:receive()
    if users[tcp_client] ~= nil or user_exists(users, username) then
        return nil, error(messages.user_login_error(username))
    else
        if not err then
            tcp_client:send(messages.user_password())
            local pwd, _err = tcp_client:receive()
            if user_password(username, pwd) then
                print("user login " .. username)
                tcp_client:settimeout(nil)
                tcp_client:setoption("keepalive", true)
                tcp_client:send(messages.user_welcome(username))
                tcp_client:send(messages.help())
                tcp_client:send(messages.user_prompt(username))
                local user = require("chat.user")
                return user.new(username, tcp_client)
            else
                return nil, error(messages.user_password_error())
            end
        else
            return nil, error(err)
        end
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
