local sha1 = require("sha1")

local user = {}

---Create a user record { username: string, tcp_client: socket.client }
---@alias socket.client socket.client: luasocket rock import
---@param username string
---@param tcp_client socket.client
---@return table: user table record { username: string, tcp_client: socket.client }
function user.new(username, tcp_client)
    return { username = username, tcp_client = tcp_client }
end

function user.is_valid_login(username, password)
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

function user.is_connected_user(users, username)
    for _, cuser in pairs(users) do
        if cuser.username == username then
            return true
        end
    end
    return false
end

return user
