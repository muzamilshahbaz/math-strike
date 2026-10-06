# Google Sign-In & Drive setup

Math Strike uses Google only to link a player's account and to store
backups in the **Drive app data folder** — a hidden folder private to the
app. The only Drive scope requested is
`https://www.googleapis.com/auth/drive.appdata` (plus `openid email profile`
on web and desktop to identify the account).

Until this is configured, **development builds run in demo mode** (a
labelled demo account and an in-memory Drive). Production builds
(`APP_ENV=production`) refuse to sign in without configuration.

## 1. Google Cloud project

1. Open <https://console.cloud.google.com/> and create a project
   (e.g. *Math Strike*).
2. **APIs & Services → Library** → enable **Google Drive API**.

## 2. OAuth consent screen

**APIs & Services → OAuth consent screen** (*Google Auth Platform*):

1. App name *Math Strike*, support e-mail, developer contact.
2. **Data access → Add scopes**: `.../auth/drive.appdata`, `openid`,
   `.../auth/userinfo.email`, `.../auth/userinfo.profile`.
   `drive.appdata` is a *non-sensitive* scope, so no security assessment
   is required.
3. **Audience**: while *Testing*, add your Google accounts as test users.
   Publish to *Production* before release (Phase 17).

## 3. OAuth clients

**APIs & Services → Credentials → Create credentials → OAuth client ID.**
Create one per platform you ship:

| Client type | Used by | Notes |
|---|---|---|
| **Web application** | Web *and* Android | Add your web origins under *Authorized JavaScript origins* (e.g. `http://localhost:8765`, your production domain). Android uses this ID as `serverClientId`. |
| **Android** | Android | Package `com.mathstrike.math_strike` + the **SHA-1** of each signing key (`cd android && ./gradlew signingReport`). No value goes into the app — the match is automatic. |
| **iOS** | iOS and macOS | Bundle ID `com.mathstrike.mathStrike`. |
| **Desktop app** | Windows and Linux | Gives a client ID **and** client secret. For installed apps Google does not treat the secret as confidential. |

## 4. Configure the build

```bash
cp config/google.example.json config/google.json   # git-ignored
```

Fill in the IDs, then pass the file to every `flutter run` / `flutter build`:

```bash
flutter run --dart-define-from-file=config/google.json
```

### iOS / macOS extra step

Add the **reversed** iOS client ID as a URL scheme so Google can return to
the app. In `ios/Runner/Info.plist` (and `macos/Runner/Info.plist`):

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <!-- e.g. com.googleusercontent.apps.1234567890-abc -->
      <string>com.googleusercontent.apps.YOUR_IOS_CLIENT_ID_PREFIX</string>
    </array>
  </dict>
</array>
```

macOS also needs the **Keychain Sharing** capability (Xcode → Signing &
Capabilities), which requires a development team.

## 5. Verify

1. Launch the app: the splash is followed by **Sign in**.
2. Sign in: an account picker (pop-up on web, browser tab on desktop)
   appears, then the consent screen lists *"See, create, and delete its own
   configuration data in your Google Drive"*.
3. You land on **Looking for your backup…** → **No backup yet** →
   onboarding.

## Trying the restore flow without credentials

```bash
flutter run --dart-define=DEMO_BACKUP=true
```

The demo Drive then contains a sample backup (dark *Neon* theme, 110 %
text). After the demo sign-in it is restored automatically — the app
switches theme, proving the data was applied.

## Troubleshooting

| Symptom | Cause |
|---|---|
| `clientConfigurationError` / `DEVELOPER_ERROR` on Android | SHA-1 or package name not registered, or wrong `GOOGLE_SERVER_CLIENT_ID` (must be the *Web* client). |
| Web pop-up blocked | Sign-in must start from the button press (it does); check the browser's pop-up settings. |
| `redirect_uri_mismatch` on web | The origin is missing from *Authorized JavaScript origins*. |
| `access_denied` | Account not listed as a test user while the consent screen is in *Testing*. |
