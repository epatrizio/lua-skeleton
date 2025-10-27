local user = {}

---Create a user record { username: string, tcp_client: socket.client }
---@alias socket.client socket.client: luasocket rock import
---@param username string
---@param tcp_client socket.client
---@return table: user table record { username: string, tcp_client: socket.client }
function user.new(username, tcp_client)
    return { username = username, tcp_client = tcp_client }
end

return user
