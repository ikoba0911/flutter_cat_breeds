.DEFAULT_GOAL = setup

init:
	@echo "init"
	@if ! command -v fvm >/dev/null 2>&1; then \
		echo "fvm not found. Installing..."; \
		dart pub global activate fvm; \
	else \
		echo "fvm already installed. Skipping activate."; \
	fi
	fvm install
	fvm flutter pub get
	fvm dart run build_runner build --delete-conflicting-outputs
setup:
	@echo "setup"
	fvm flutter pub get
	fvm dart run build_runner build --delete-conflicting-outputs
refresh:
	@echo "refresh"
	fvm flutter pub cache repair
	dart pub global activate fvm
	fvm flutter clean
	fvm flutter pub get
	fvm dart run build_runner build --delete-conflicting-outputs
clean:
	fvm flutter clean
	fvm flutter pub get
	fvm dart run build_runner build --delete-conflicting-outputs
genfile:
	fvm dart run build_runner build --delete-conflicting-outputs
