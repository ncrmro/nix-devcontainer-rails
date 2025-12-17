.PHONY: install
install:
	bundle config set --local path 'vendor/bundle'
	bundle install

.PHONY: test
test:
	bundle exec rspec

.PHONY: run
run:
	bundle exec bin/rails server -p 3000

.PHONY: docker-build
docker-build:
	docker build -t app .