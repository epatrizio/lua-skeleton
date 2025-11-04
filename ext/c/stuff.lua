-- configuration example
var_1 = 42
var_2 = "value_2"
var_3 = { key_1 = 1, key_2 = 2 }

-- global function examples

function hello_world()
    print("Hello, world!")
end

function hello_str(world)
    return "Hello, " .. world .. "!"
end

function hello(world)
    print(hello_str(world))
end
