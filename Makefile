ext_c_build:
	gcc -fPIC -I/usr/local/include/ -L/usr/local/lib/liblua.a \
		-g -Wall -Wextra -Werror ext/c/main.c -o ext_c -llua -lm

ext_c_run:
	./ext_c
