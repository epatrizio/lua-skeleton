ext_c_build:
	gcc -fPIC -I/usr/local/include/ -L/usr/local/lib/liblua.a \
		-g -Wall -Wextra -Werror ext/c/main.c -o ext_c -llua -lm

ext_c_run:
	./ext_c

ext_ocaml_build:
	cd ext/ocaml; \
	dune build

ext_ocaml_run:
	cd ext/ocaml; \
	dune exec ocaml-lua-exp
