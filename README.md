# A-One iOS App

A production-ready Flutter iOS WebView application with clean architecture, proper state management, and iOS-optimized behavior. Ready for App Store deployment.

## 🎯 Features

✅ **Splash Screen** - Custom animated splash with logo and app name  
✅ **WebView Integration** - Full-featured web browser with iOS optimizations  
✅ **Pull to Refresh** - iOS-native CupertinoSliverRefreshControl  
✅ **Offline Handling** - Automatic detection with custom offline page  
✅ **Clean Architecture** - Organized code structure with separation of concerns  
✅ **State Management** - Provider pattern for reactive updates  
✅ **iOS Optimized** - WKWebView, swipe gestures, and iOS design guidelines  
✅ **App Store Ready** - Proper configuration and permissions  

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── config/
│   └── app_config.dart         # Centralized configuration
├── screens/
│   ├── splash_screen.dart      # Animated splash screen
│   └── webview_screen.dart     # Main WebView with pull-to-refresh
├── services/
│   └── connectivity_service.dart # Internet connectivity monitoring
└── widgets/
    ├── offline_page.dart       # Offline UI
    └── loading_indicator.dart  # WebView loading indicator
```

---

## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Xcode 14.0 or higher (for iOS development)
- macOS (required for iOS builds)
- Apple Developer Account (for App Store deployment)

### Installation

1. **Clone or navigate to the project directory:**
   ```bash
   cd "c:\Users\Acer\Desktop\A-One IOS App"
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate native splash screens:**
   ```bash
   flutter pub run flutter_native_splash:create
   ```

4. **Run the app:**
   ```bash
   # iOS Simulator
   flutter run -d iPhone

   # Physical iOS Device
   flutter run -d <device-id>
   ```

---

## ⚙️ Configuration

### 1. Change Website URL

Edit `lib/config/app_config.dart`:

```dart
/// Primary URL to load in WebView
static const String websiteUrl = 'https://www.yourwebsite.com';

/// Allowed domains (same domain links stay in WebView)
static List<String> allowedDomains = [
  'yourwebsite.com',
  'www.yourwebsite.com',
];
```

### 2. Customize App Name & Branding

Edit `lib/config/app_config.dart`:

```dart
/// App Name - shown on splash screen and app bar
static const String appName = 'Your App Name';

/// App Version
static const String appVersion = '1.0.0';

/// Primary color (hex value)
static const int primaryColorValue = 0xFF2196F3;
```

### 3. Replace App Logo

1. Replace the placeholder logo in:
   - `assets/images/logo.png` (1024x1024 recommended)

2. Regenerate splash screen:
   ```bash
   flutter pub run flutter_native_splash:create
   ```

### 4. Configure Splash Screen Duration

Edit `lib/config/app_config.dart`:

```dart
/// Splash screen duration in seconds
static const int splashDurationSeconds = 3;
```

### 5. iOS App Transport Security (ATS)

If your website uses HTTP (not recommended for production):

Edit `ios/Runner/Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

**⚠️ For Production:** Use HTTPS and remove or set to `false`.

For specific domains only:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>yourwebsite.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <key>NSIncludesSubdomains</key>
            <true/>
        </dict>
    </dict>
</dict>
```

---

## 📱 iOS Configuration

### Bundle Identifier

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select **Runner** target
3. Change **Bundle Identifier** to your unique ID (e.g., `com.yourcompany.appname`)
4. Select your **Team** (Apple Developer Account)

### App Icons

1. Create app icons using [App Icon Generator](https://www.appicon.co/)
2. Replace icons in: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### Display Name

Edit `ios/Runner/Info.plist`:

```xml
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
```

### Minimum iOS Version

The app supports iOS 13+. To change:

Edit `ios/Runner/Info.plist`:

```xml
<key>MinimumOSVersion</key>
<string>13.0</string>
```

---

## 🏗️ Build for App Store

### 1. Build Release IPA

```bash
# Build for iOS (archive)
flutter build ios --release

# Or build IPA directly
flutter build ipa --release
```

### 2. Using Xcode

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select **Any iOS Device (arm64)** as target
3. Go to **Product > Archive**
4. Once archived, click **Distribute App**
5. Choose **App Store Connect**
6. Follow the prompts to upload

### 3. TestFlight Distribution

1. Upload to App Store Connect via Xcode
2. Go to [App Store Connect](https://appstoreconnect.apple.com/)
3. Select your app
4. Go to **TestFlight** tab
5. Add internal/external testers
6. Submit for beta review

### 4. App Store Submission

1. Complete app metadata in App Store Connect:
   - App name, description, keywords
   - Screenshots (required sizes)
   - Privacy policy URL
   - Support URL
   
2. Submit for review
3. Wait for Apple approval (typically 24-48 hours)

---

## 🔧 Advanced Configuration

### Enable/Disable Features

Edit `lib/config/app_config.dart`:

```dart
/// Enable JavaScript in WebView
static const bool enableJavaScript = true;

/// Enable pull-to-refresh
static const bool enablePullToRefresh = true;

/// Show app bar in WebView
static const bool showAppBar = false;

/// Open external links in system browser
static const bool openExternalLinksInBrowser = true;
```

### Custom Offline Page

Edit `lib/widgets/offline_page.dart` to customize the offline UI.

### Custom Loading Indicator

Edit `lib/widgets/loading_indicator.dart` to customize the loading animation.

---

## 📝 App Permissions

The following permissions are configured in `Info.plist`:

- ✅ Internet Access (required)
- ✅ Camera Access (for file uploads)
- ✅ Photo Library Access (for file uploads)
- ✅ Microphone Access (for audio recording)
- ⚠️ Location Access (optional, commented out by default)

**To remove unused permissions:**
Delete or comment out the corresponding entries in `ios/Runner/Info.plist`.

---

## 🐛 Troubleshooting

### Issue: WebView not loading

**Solution:** Check `NSAppTransportSecurity` in `Info.plist` and ensure your URL is accessible.

### Issue: Splash screen not showing

**Solution:** Run:
```bash
flutter pub run flutter_native_splash:create
flutter clean
flutter pub get
```

### Issue: Build fails in Xcode

**Solution:**
1. Update CocoaPods: `pod repo update`
2. Clean build: `flutter clean`
3. Delete `ios/Pods` and `ios/Podfile.lock`
4. Run: `cd ios && pod install && cd ..`

### Issue: App rejected for ATS

**Solution:** Use HTTPS URLs or configure specific domain exceptions in `Info.plist`.

---

## 📊 Performance Optimization

- ✅ WKWebView (iOS native, better performance than UIWebView)
- ✅ Lazy loading (WebView loads only when needed)
- ✅ Memory management (automatic cleanup on dispose)
- ✅ Cached assets (splash screen uses native caching)
- ✅ Optimized animations (hardware-accelerated)

---

## 📚 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `webview_flutter` | ^4.4.4 | WebView widget |
| `webview_flutter_wkwebview` | ^3.9.4 | iOS WKWebView implementation |
| `connectivity_plus` | ^5.0.2 | Internet connectivity detection |
| `url_launcher` | ^6.2.2 | Launch external URLs |
| `provider` | ^6.1.1 | State management |
| `flutter_native_splash` | ^2.3.8 | Native splash screen |

---

## 🎨 Customization Checklist

- [ ] Update website URL in `app_config.dart`
- [ ] Change app name in `app_config.dart`
- [ ] Replace logo in `assets/images/logo.png`
- [ ] Update bundle identifier in Xcode
- [ ] Configure allowed domains in `app_config.dart`
- [ ] Set primary color in `app_config.dart`
- [ ] Update Info.plist display name
- [ ] Add app icons in Xcode
- [ ] Test on iOS simulator
- [ ] Test on physical iOS device
- [ ] Build release IPA
- [ ] Upload to TestFlight
- [ ] Submit to App Store

---

## 📄 License

This project is licensed for production use. Modify as needed for your requirements.

---

## 🤝 Support

For issues or questions:
1. Check the troubleshooting section
2. Review Flutter documentation: https://flutter.dev/docs
3. WebView plugin docs: https://pub.dev/packages/webview_flutter

---

## 🎯 Key Features Implementation

### Splash Screen
- ✅ Custom animated logo
- ✅ Fade and scale animations
- ✅ Configurable duration
- ✅ Native splash integration

### WebView
- ✅ WKWebView (iOS native)
- ✅ JavaScript enabled
- ✅ DOM storage enabled
- ✅ Progress indicator
- ✅ Back button navigation
- ✅ External link handling
- ✅ iOS swipe-back gesture

### Pull to Refresh
- ✅ CupertinoSliverRefreshControl (iOS)
- ✅ RefreshIndicator (Android fallback)
- ✅ Smooth native behavior

### Offline Handling
- ✅ Real-time connectivity monitoring
- ✅ Custom offline page UI
- ✅ Automatic reconnection
- ✅ Retry functionality

---

**Built with ❤️ using Flutter & Dart**
