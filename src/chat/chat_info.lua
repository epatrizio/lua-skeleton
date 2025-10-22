local chat_info = {}

function chat_info.server_start(ip, port)
    return "chat server up! telnet listening to " .. ip .. ":" .. port
end

function chat_info.help()
    local help =
        "tiny chat server commands:\n" ..
        "- /help\n" ..
        "- /logout\n"
    return help
end

function chat_info.user_login(username)
    return "Welcome, " .. username .. " ;)\n"
end

function chat_info.user_logout()
    return "Goodbye and see you soon ;)\n"
end

return chat_info
