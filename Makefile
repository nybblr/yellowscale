.PHONY: build static clean

build: static $(patsubst sass/%.scss,build/css/%.css,$(wildcard sass/*))

static:
	cp -r CNAME *.html fonts images css js d build

clean:
	rm -rf ./build/*

build/css/%.css: sass/%.scss
	sassc $< > $@
