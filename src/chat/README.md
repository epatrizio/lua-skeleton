# lua-skeleton - Chat *toy* app

Here is a small *toy* application that shows how a program could be implemented.
This is a naive Chat App built on the [luasocket](https://lunarmodules.github.io/luasocket/)
module (Network support for the Lua language).

* `chat_app` command: server start (see build.install.bin section in .rockspec file for app name config)

```console
data mode: txt
chat server up! telnet listening to 127.0.0.1:1234
```

* `data mode: txt -- db`: data configuration (text file -- [sqlite3](https://lua.sqlite.org) db file).
See `setup.lua` for configuration details.
  * `txt mode`: 1 user per line, line format = `username_1:password_1_sha1`
  * `db mode`, to create a database:
    * edit `users.sql` file: enter user/password values
    * execute the command-line: `sqlite3 chat.db .mode users.sql`\
    database name `chat.db` (for example) must be the same in the previous command-line
    and in `setup.lua` file.
* The server is ready to process [Telnet](https://en.wikipedia.org/wiki/Telnet) requests
  * `telnet localhost 1234` command: Telnet connection from a terminal

```console
Hello! Please, enter your username: user_name
Please, enter your password: user_pwd
Welcome, eric ;)
tiny chat server commands:
 - /help
 - /users : connected users list
 - /msg_all : send a message to all connected users
 - /msg *user* : send a message to a user. ex. /msg *username* "message" 
 - /logout
$ eric #
```
