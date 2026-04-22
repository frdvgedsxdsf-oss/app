# Logo Placeholder

This directory should contain your app logo.

## Required Files:

- `logo.png` - Main app logo (1024x1024 pixels recommended)
  - Used for splash screen
  - Should be PNG format with transparent background (optional)

- `offline_icon.png` - Offline indicator icon (optional)
  - Used on the offline page
  - Can be replaced with built-in icons if not needed

## How to Add Your Logo:

1. Create or design your app logo
2. Export as PNG (1024x1024 pixels)
3. Name it `logo.png`
4. Place it in this directory (`assets/images/`)
5. Run: `flutter pub run flutter_native_splash:create`

## Free Logo Resources:

- Canva: https://www.canva.com/
- LogoMakr: https://logomakr.com/
- Hatchful: https://www.shopify.com/tools/logo-maker

## App Icon Generation:

Use these tools to generate iOS app icons:
- AppIcon.co: https://www.appicon.co/
- MakeAppIcon: https://makeappicon.com/

After generating:
1. Download the icon set
2. Replace icons in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
