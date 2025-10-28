require "busted.runner" ()

local _client = require("chat.client")
local messages = require("chat.messages")
local _server = require("chat.server")
local user = require("chat.user")

describe("chat app", function ()
    it("messages", function ()
        assert.are.equal(messages.user_login(), "Hello! Please, enter your username: ")
        assert.are.equal(messages.user_prompt("username"), "$ username # ")
        -- to be completed
    end)
    it("user.new", function ()
        local my_user = user.new("my_username", nil)
        assert.are.equal(my_user.username, "my_username")
        -- to be completed
    end)
    -- specific topic of socket external package testing (not the purpose here)
    it("clients", function ()
        -- todo
    end)
    it("server", function ()
        -- toto
    end)
end)
