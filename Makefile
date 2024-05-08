run:
	flutter run

build-app:
	flutter build apk --release

deploy-app:
	firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk   \
    --app 1:125073612234:android:fcacfd503ccbe1848e8333  \
    --release-notes "Bug fixes and improvements" --groups "User"
