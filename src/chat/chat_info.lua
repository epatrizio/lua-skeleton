local chat_info = {}

function chat_info.server_start(ip, port)
    return "chat server up! telnet listening to " .. ip .. ":" .. port
end

function chat_info.server_loop_error(msg)
    return "chat server down! error:" .. msg
end

function chat_info.help()
    local help =
        "tiny chat server commands:\n" ..
        " - /help\n" ..
        " - /users : connected users list\n" ..
        " - /logout\n"
    return help
end

function chat_info.user_login()
    return "Hello! Please, enter your username: "
end

function chat_info.user_welcome(username)
    return "Welcome, " .. username .. " ;)\n"
end

function chat_info.user_prompt(username)
    return "$ " .. username .. " > "
end

function chat_info.user_logout(username)
    return "Goodbye " .. username .. " and see you soon ;)\n"
end

return chat_info
