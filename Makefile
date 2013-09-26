clean:
	rm -rf build

compile-coffee:
	./node_modules/.bin/coffee \
		--compile \
		--bare \
		--output ./build \
		./src

build: clean compile-coffee

unit-test:
	@NODE_ENV=test \
	./node_modules/.bin/jasmine-node \
		--forceexit \
		--verbose \
		--coffee \
		./tests/unit-tests

test: unit-test

.PHONY: clean compile-coffee build unit-test test
