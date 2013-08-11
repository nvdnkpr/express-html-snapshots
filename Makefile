build:
	./node_modules/.bin/coffee \
		--compile \
		--bare \
		--output ./build \
		./lib

test:
	@NODE_ENV=test \
	./node_modules/.bin/mocha \
		--recursive \
		--reporter list \
		--timeout 10000 \
		--bail \
		tests/*.test.coffee \
		--require coffee-script

.PHONY: build test
