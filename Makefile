
REPORTER = list

test:
	@NODE_ENV=test \
	./node_modules/.bin/mocha \
		--recursive \
		--reporter $(REPORTER) \
		--timeout 10000 \
		--bail \
		tests/*.test.coffee \
		--require coffee-script
