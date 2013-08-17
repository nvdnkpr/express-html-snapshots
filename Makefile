build:
	./node_modules/.bin/coffee \
		--compile \
		--bare \
		--output ./lib \
		./src

test:
	@NODE_ENV=test \
	./node_modules/.bin/jasmine-node \
		--forceexit \
		--verbose \
		--coffee \
		./tests

.PHONY: build test
