.PHONY: install format test clean build bundle

# Set default env as develop.
ifeq ($(ENV),)
ENV := develop
endif

GENERATE := flutter pub run build_runner build --delete-conflicting-outputs

bundle:
	@\cp -rf ../schema/build/dart/ ./openapi
	@echo "Success!"
clean:
	flutter clean

generate:
	flutter pub get && $(GENERATE)

start: clean generate
	flutter run --debug -d web-server --web-port $(PORT) --web-hostname 0.0.0.0

run: hot-reload start

hot-reload:
	while sleep 1; do \
		find lib -type f | entr -r make start; \
	done

build: clean generate
	flutter build web --release

test:
	flutter test
