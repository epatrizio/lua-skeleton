local user = {}

function user.new(username, tcp_client)
    return { username = username, tcp_client = tcp_client }
end

return user
