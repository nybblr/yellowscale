SHELL = /bin/bash

.PHONY: build static clean deploy

build: static $(patsubst sass/%.scss,build/css/%.css,$(wildcard sass/*))

static:
	cp -r CNAME *.html fonts images css js d build

clean:
	rm -rf ./build/*

deploy: build
	pushd build && \
	git add -A && \
	git commit -m "Automated commit at $(shell date)" && \
	git push -f deploy master:gh-pages && \
	popd

build/css/%.css: sass/%.scss
	sassc $< > $@
