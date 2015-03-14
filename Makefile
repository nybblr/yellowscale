NPM_BIN       = ./node_modules/.bin

MODULE        = app
BUILD_DIR     = build

JS_SRC_DIR    = scripts
CSS_SRC_DIR   = styles
HTML_SRC_DIR  = pages

STATIC_DIR    = static

JS_ENTRY      = $(JS_SRC_DIR)/jquery.min.js \
								$(JS_SRC_DIR)/jquery.scrollzer.min.js \
								$(JS_SRC_DIR)/jquery.scrolly.min.js \
								$(JS_SRC_DIR)/skel.min.js \
								$(JS_SRC_DIR)/skel-layers.min.js \
								$(JS_SRC_DIR)/init.js
JS_BUNDLE     = $(BUILD_DIR)/$(MODULE).js

CSS_ENTRY     = $(CSS_SRC_DIR)/$(MODULE).scss
CSS_BUNDLE    = $(BUILD_DIR)/$(MODULE).css

HTML_ENTRY    = $(HTML_SRC_DIR)/index.jade
HTML_BUNDLE   = $(BUILD_DIR)/index.html

FONTS_ENTRY   = $(wildcard fonts/*)
FONTS_DIR     = $(BUILD_DIR)/fonts

.PHONY: build serve watch clean static fonts scripts styles pages

build: $(BUILD_DIR) $(FONTS_DIR) static fonts scripts styles pages

serve: build
	@$(NPM_BIN)/serve $(BUILD_DIR)

watch:
	@fswatch -o assets | xargs -n1 -I{} make build

clean:
	@rm -rf $(BUILD_DIR)/*

static:
	@cp -r $(STATIC_DIR)/* $(BUILD_DIR)

fonts:
	@cp $(FONTS_ENTRY) $(FONTS_DIR)

scripts:
	@$(NPM_BIN)/uglifyjs $(JS_ENTRY) --compress --mangle -o $(JS_BUNDLE)

styles:
	@sassc $(CSS_ENTRY) $(CSS_BUNDLE)

pages:
	@$(NPM_BIN)/jade $(HTML_ENTRY) -o $(BUILD_DIR)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(FONTS_DIR):
	@mkdir -p $(FONTS_DIR)
