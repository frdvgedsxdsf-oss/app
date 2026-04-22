# iOS Build & Deployment Guide

Complete guide for building and deploying your A-One iOS app to the App Store.

---

## Prerequisites

- macOS with Xcode 14.0+
- Apple Developer Account ($99/year)
- Valid development certificate and provisioning profile
- Flutter SDK installed and configured

---

## Part 1: Xcode Configuration

### Step 1: Open Project in Xcode

```bash
cd "c:\Users\Acer\Desktop\A-One IOS App"
open ios/Runner.xcworkspace
```

### Step 2: Configure Bundle Identifier

1. Select **Runner** in the project navigator
2. Select **Runner** target
3. Go to **General** tab
4. Change **Bundle Identifier** to your unique ID:
   - Format: `com.yourcompany.appname`
   - Example: `com.aone.iosapp`

### Step 3: Select Development Team

1. Under **Signing & Capabilities**
2. Select your **Team** from the dropdown
3. Ensure **Automatically manage signing** is checked

### Step 4: Update Display Name

In `Info.plist`, update:
```xml
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
```

---

## Part 2: App Icons

### Using AppIcon.co (Recommended)

1. Go to https://www.appicon.co/
2. Upload your 1024x1024 logo
3. Select **iPhone** and **iPad**
4. Download the generated icons
5. Replace in: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### Manual Setup

Create icons in these sizes:
- 20x20 (iPhone Notification 2x, 3x)
- 29x29 (iPhone Settings 2x, 3x)
- 40x40 (iPhone Spotlight 2x, 3x)
- 60x60 (iPhone App 2x, 3x)
- 1024x1024 (App Store)

---

## Part 3: Build Configuration

### Build Settings

1. In Xcode, go to **Runner** target > **Build Settings**
2. Set **iOS Deployment Target** to `13.0` or higher
3. Ensure **Architectures** includes `arm64`

### Release Configuration

1. Product > Scheme > Edit Scheme
2. Change **Build Configuration** to `Release`
3. Uncheck **Debug executable**

---

## Part 4: Build IPA

### Method 1: Using Flutter CLI

```bash
# Build IPA
flutter build ipa --release

# Output location:
# build/ios/ipa/a_one_ios_app.ipa
```

### Method 2: Using Xcode Archive

1. In Xcode, select **Any iOS Device (arm64)**
2. Product > Clean Build Folder (⇧⌘K)
3. Product > Archive
4. Wait for archive to complete
5. Archive window opens automatically

---

## Part 5: App Store Connect Setup

### Create App Listing

1. Go to https://appstoreconnect.apple.com/
2. Select **My Apps**
3. Click **+** > **New App**
4. Fill in:
   - Platform: iOS
   - Name: Your app name
   - Primary Language: English
   - Bundle ID: (select the one you configured)
   - SKU: Unique identifier (e.g., `aone-ios-001`)

### App Information

Complete these sections:

**1. App Information**
- Category: Choose appropriate category
- Content Rights: Indicate if it contains third-party content

**2. Pricing and Availability**
- Price: Free or set price
- Availability: Select countries

**3. App Privacy**
- Privacy Policy URL (required)
- Data types collected (if any)

**4. App Review Information**
- Contact information
- Demo account credentials (if login required)
- Notes for reviewer

---

## Part 6: Upload to App Store

### Using Xcode Organizer

1. After archiving, in Organizer window:
2. Click **Distribute App**
3. Select **App Store Connect**
4. Click **Upload**
5. Select signing options:
   - **Automatically manage signing** (recommended)
   - Or manually select certificate
6. Click **Upload**
7. Wait for upload to complete

### Using Transporter App (Alternative)

1. Download Transporter from Mac App Store
2. Locate your IPA file
3. Drag and drop into Transporter
4. Click **Deliver**

---

## Part 7: TestFlight Beta Testing

### Add Beta Testers

1. In App Store Connect, go to **TestFlight** tab
2. Under **Internal Testing**:
   - Add internal testers (up to 100)
   - They can test immediately
3. Under **External Testing**:
   - Add external testers (up to 10,000)
   - Requires beta app review (24-48 hours)

### Submit for Beta Review

1. Select build
2. Add **What to Test** notes
3. Submit for review
4. Wait for approval

---

## Part 8: App Store Submission

### Complete App Metadata

**1. App Store Description**
- Name (30 characters max)
- Subtitle (30 characters max)
- Description (4000 characters max)
- Keywords (100 characters max)
- Support URL
- Marketing URL (optional)

**2. Screenshots**

Required sizes:
- 6.7" Display (iPhone 14 Pro Max): 1290x2796
- 6.5" Display (iPhone 11 Pro Max): 1242x2688
- 5.5" Display (iPhone 8 Plus): 1242x2208

Use simulator to capture:
```bash
# Launch simulator
open -a Simulator

# Take screenshot: Cmd+S
```

**3. App Preview Video** (Optional)
- 15-30 seconds
- Same sizes as screenshots

**4. Promotional Text**
- 170 characters max
- Can be updated without new version

### Select Build

1. Under **Build** section
2. Click **+** next to build number
3. Select your uploaded build
4. Click **Done**

### Submit for Review

1. Complete all required fields
2. Save changes
3. Click **Add for Review**
4. Click **Submit to App Review**

---

## Part 9: App Review Process

### Timeline

- **Waiting for Review**: 1-3 days
- **In Review**: 1-2 days
- **Total**: Usually 2-5 days

### Common Rejection Reasons

1. **Incomplete Information**: Missing privacy policy, support URL
2. **Crashes**: App crashes during review
3. **Broken Links**: Website not loading properly
4. **Privacy Issues**: Not disclosing data collection
5. **Guideline Violations**: Not following App Store guidelines

### If Rejected

1. Read rejection reason carefully
2. Fix the issues
3. Upload new build (if code changes needed)
4. Respond in Resolution Center
5. Resubmit for review

---

## Part 10: Post-Approval

### Release Options

**1. Automatic Release**
- App goes live immediately after approval

**2. Manual Release**
- You control when app goes live
- Click **Release This Version** when ready

### Monitor Performance

1. Check **App Analytics** in App Store Connect
2. Monitor user reviews
3. Respond to user feedback
4. Plan updates and improvements

---

## Version Updates

### For New Versions:

1. Update version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2
   ```

2. Update `CHANGELOG.md` with new features

3. Build new IPA:
   ```bash
   flutter build ipa --release
   ```

4. Upload to App Store Connect

5. In App Store Connect:
   - Create new version
   - Add "What's New" description
   - Submit for review

---

## Troubleshooting

### Issue: Code signing error

**Solution:**
- Ensure valid certificate in Keychain
- Check provisioning profile
- Try: Xcode > Preferences > Accounts > Download Manual Profiles

### Issue: Archive not showing in Organizer

**Solution:**
- Ensure "Generic iOS Device" is selected before archiving
- Check that build target is set correctly

### Issue: Upload fails

**Solution:**
- Check internet connection
- Verify Apple Developer account is active
- Try uploading via Transporter app instead

### Issue: Build number already exists

**Solution:**
- Increment build number in `pubspec.yaml`
- Example: `1.0.0+1` → `1.0.0+2`

---

## Quick Reference Commands

```bash
# Get dependencies
flutter pub get

# Generate splash screens
flutter pub run flutter_native_splash:create

# Clean build
flutter clean

# Build iOS (archive)
flutter build ios --release

# Build IPA
flutter build ipa --release

# Run on simulator
flutter run -d iPhone

# List devices
flutter devices

# Check Flutter doctor
flutter doctor -v
```

---

## Important Links

- **App Store Connect**: https://appstoreconnect.apple.com/
- **Apple Developer**: https://developer.apple.com/
- **App Store Review Guidelines**: https://developer.apple.com/app-store/review/guidelines/
- **Human Interface Guidelines**: https://developer.apple.com/design/human-interface-guidelines/
- **Flutter iOS Deployment**: https://docs.flutter.dev/deployment/ios

---

## Support

For build issues:
1. Check Flutter documentation
2. Review Apple Developer forums
3. Check Stack Overflow for common errors

Good luck with your App Store submission! 🚀
