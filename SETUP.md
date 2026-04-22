# SETUP INSTRUCTIONS

## Quick Start Guide

Follow these steps to get your A-One iOS WebView app up and running:

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Configure Your App

**a) Update Website URL:**
- Open `lib/config/app_config.dart`
- Change `websiteUrl` to your website
- Update `allowedDomains` list

**b) Customize App Name:**
- Update `appName` in `lib/config/app_config.dart`
- Update `CFBundleDisplayName` in `ios/Runner/Info.plist`

**c) Set Bundle Identifier:**
- Open `ios/Runner.xcworkspace` in Xcode
- Select Runner > General
- Change Bundle Identifier (e.g., com.yourcompany.appname)
- Select your Development Team

### 3. Add Your Logo

- Replace `assets/images/logo.png` with your logo (1024x1024 recommended)
- Run: `flutter pub run flutter_native_splash:create`

### 4. Run the App

**iOS Simulator:**
```bash
flutter run -d iPhone
```

**Physical Device:**
```bash
flutter run -d <device-id>
```

### 5. Build for App Store

```bash
# Build IPA
flutter build ipa --release

# Or using Xcode
# Open ios/Runner.xcworkspace
# Product > Archive > Distribute App
```

---

## Configuration Checklist

- [ ] Install dependencies (`flutter pub get`)
- [ ] Update website URL in `app_config.dart`
- [ ] Change app name in `app_config.dart` and `Info.plist`
- [ ] Replace logo in `assets/images/logo.png`
- [ ] Generate splash screen (`flutter pub run flutter_native_splash:create`)
- [ ] Update bundle identifier in Xcode
- [ ] Select development team in Xcode
- [ ] Test on simulator
- [ ] Test on physical device
- [ ] Build release IPA
- [ ] Upload to TestFlight/App Store

---

## Important Files to Modify

| File | Purpose | What to Change |
|------|---------|---------------|
| `lib/config/app_config.dart` | Main configuration | URL, app name, colors, domains |
| `ios/Runner/Info.plist` | iOS settings | Display name, permissions |
| `assets/images/logo.png` | App logo | Replace with your logo |
| `pubspec.yaml` | Dependencies | App name, version |

---

## Need Help?

Check the comprehensive README.md for detailed instructions and troubleshooting.
