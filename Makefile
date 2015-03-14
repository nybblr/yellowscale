.PHONY: build

build: $(patsubst sass/%.scss,css/%.css,$(wildcard sass/*))

css/%.css: sass/%.scss
	sassc $< > $@
