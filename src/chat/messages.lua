local messages = {}

function messages.server_start(ip, port)
    return "chat server up! telnet listening to " .. ip .. ":" .. port
end

function messages.server_loop_error(msg)
    return "chat server down! error:" .. msg
end

function messages.help()
    local help =
        "tiny chat server commands:\n" ..
        " - /help\n" ..
        " - /users : connected users list\n" ..
        " - /msg_all : send a message to all connected users\n" ..
        " - /msg *user* : send a message to a user. ex. /msg *username* \"message\" \n" ..
        " - /logout\n"
    return help
end

function messages.user_login()
    return "Hello! Please, enter your username: "
end

function messages.user_welcome(username)
    return "Welcome, " .. username .. " ;)\n"
end

function messages.user_prompt(username)
    return "$ " .. username .. " # "
end

function messages.invalid_username(username)
    return "unknown username *" .. username .. "*\n"
end

function messages.invalid_command(msg)
    return "invalid command! received message:" .. msg .. "\n"
end

function messages.user_logout(username)
    return "Goodbye " .. username .. " and see you soon ;)\n"
end

return messages
