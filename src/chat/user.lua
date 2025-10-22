local user = {}

function user.new(username, client)
    return { username = username, client = client }
end

return user
