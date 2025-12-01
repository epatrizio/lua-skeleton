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

fact_ocaml_build:
	ocamlfind ocamlopt -output-obj -o factorial_ml.o src/factorial.ml \
	-linkpkg -package ocaml-lua \
	-thread; \
	gcc -L`ocamlopt -where` -shared -o factorial_ml.so factorial_ml.o \
	`ocamlopt -where`/../ocaml-lua/liblua_stubs.a -lasmrun_pic -lthreadsnat -lunix -lm -ldl
