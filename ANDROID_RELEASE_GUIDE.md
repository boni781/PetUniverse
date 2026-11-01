# PetUniverse Android release signing and build

This guide prepares local Android release signing for the multi-platform
Release Manager. The private keystore and its password stay on the developer
workstation; neither is committed to GitHub.

## Requirements

- Flutter and Android SDK configured on Windows.
- Java keytool available in PowerShell.
- A private backup of the upload keystore.

## 1. Create the upload keystore (once)

Run from the repository root in PowerShell:

~~~powershell
New-Item -ItemType Directory -Force "./app/android" | Out-Null
keytool -genkeypair -v -keystore "./app/android/upload-keystore.jks" -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
~~~

The command asks for a keystore password, certificate details, and a key
password. Keep these passwords private. Store a second secure backup of
upload-keystore.jks; losing or replacing the upload key can complicate future
updates, especially after the app is enrolled in Google Play App Signing.

## 2. Create the local key.properties file

Open the file:

~~~powershell
notepad "./app/android/key.properties"
~~~

Enter these four properties, replacing the two password values with the
passwords you entered in the keytool prompts:

~~~properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=upload-keystore.jks
~~~

Save and close Notepad. Do not add quotes around the values. The relative
storeFile is resolved from app/android.

The repository ignore rules already exclude key.properties, .jks, and
.keystore files. Never remove those exclusions and never paste the passwords
or upload the keystore into chat or GitHub.

## 3. Verify signing configuration

From the repository root:

~~~powershell
keytool -list -v -keystore "./app/android/upload-keystore.jks" -alias upload
git check-ignore "./app/android/key.properties"
git check-ignore "./app/android/upload-keystore.jks"
~~~

The two git check-ignore commands should each print the matching ignored
path. Keep the keytool password prompt private.

## 4. Build Android locally

From the Flutter application folder:

~~~powershell
cd "./app"
flutter pub get
flutter build apk --release
flutter build appbundle --release
~~~

Expected outputs:

- build/app/outputs/flutter-apk/app-release.apk — install directly on
  compatible Android devices.
- build/app/outputs/bundle/release/app.aab — upload to Google Play
  Console; an AAB is not installed directly like an APK.

## 5. Multi-platform release

After the signing setup is verified, run python release.py from the
repository root. The next release will keep the existing Windows package and
add signed Android APK/AAB assets, separate Android SHA-256 checksums, and an
Android manifest to the same GitHub Release.

This does not publish the app to Google Play automatically. Play Console
enrollment, app listing, content declarations, and Play App Signing setup are
separate steps.
