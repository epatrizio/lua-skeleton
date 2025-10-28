printf "\n$ lua core tests:\n"
lua test/assert_factorial.lua -v

printf "\n$ luaunit tests:\n"
lua test/test_factorial.lua -v

printf "\n$ busted tests:\n"
busted -v -c    # -c : code coverage generation (luacov is needed)
luacov          # luacov.report.html generation (check .luacov file)
