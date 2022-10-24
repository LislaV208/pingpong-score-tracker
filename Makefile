build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs

android_bundle:
	flutter build appbundle

.PHONY: build_runner android_bundle