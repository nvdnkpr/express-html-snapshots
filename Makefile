build:
	./node_modules/.bin/coffee \
		--compile \
		--bare \
		--output . \
		.

test:
	@NODE_ENV=test \
	./node_modules/.bin/jasmine-node \
		--forceexit \
		--verbose \
		./tests

.PHONY: build test
