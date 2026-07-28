local sha1 = require("sha1")
local sqlite3 = require("lsqlite3")

local user = {}

---Create a user record { username: string, tcp_client: socket.client }
---@alias socket.client socket.client: luasocket rock import
---@param username string
---@param tcp_client socket.client
---@return table: user table record { username: string, tcp_client: socket.client }
function user.new(username, tcp_client)
    return { username = username, tcp_client = tcp_client }
end

local function is_valid_login_txt(username, pwd_sha1)
    for line in io.lines(_G.Users_file) do
        local i1, _ = string.find(line, username .. ":")
        local i2, _ = string.find(line, ":" .. pwd_sha1)
        if i1 ~= nil and i1 > 0 and i2 ~= nil and i2 > 0 then
            return true
        end
    end
    return false
end

local function is_valid_login_db(username, pwd_sha1)
    local db = sqlite3.open(_G.Users_db)
    local query =
        "SELECT * FROM users WHERE username='" .. username ..
        "' AND password='" .. pwd_sha1 .. "'"
    for cuser in db:nrows(query) do
        if cuser.username == username and cuser.password == pwd_sha1 then
            db:close()
            return true
        end
    end
    db:close()
    return false
end

function user.is_valid_login(username, password)
    local pwd_sha1 = sha1.sha1(password)
    if _G.Data_mode == "db" then
        return is_valid_login_db(username, pwd_sha1)
    else
        return is_valid_login_txt(username, pwd_sha1)
    end
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
