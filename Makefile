build:
	./node_modules/.bin/coffee \
		--compile \
		--bare \
		--output . \
		.

test:
	@NODE_ENV=test \
	./node_modules/.bin/mocha \
		--recursive \
		--reporter list \
		--timeout 10000 \
		--bail \
		tests/*.test.js

.PHONY: build test
