/// App Configuration
/// 
/// This file contains all configurable settings for the WebView app.
/// Update these values to customize your app without changing the core code.

class AppConfig {
  // ========== APP INFORMATION ==========
  
  /// App Name - shown on splash screen and app bar
  static const String appName = 'Divya Jyotish';

  /// App Name (Devanagari)
  static const String appNameLocal = 'दिव्य ज्योतिष';

  /// App tagline shown on splash screen
  static const String appTagline = 'Illuminate Your Path with Stars';
  
  /// App Version
  static const String appVersion = '1.0.0';
  
  // ========== WEBVIEW CONFIGURATION ==========
  
  /// Primary URL to load in WebView
  /// Change this to your website URL
  static const String websiteUrl = 'https://bishnuprasadchundali.com.np/';
  
  /// Enable JavaScript in WebView
  static const bool enableJavaScript = true;
  
  /// Enable DOM Storage
  static const bool enableDomStorage = true;
  
  /// Allow media playback without user gesture (autoplay)
  static const bool allowMediaPlaybackWithoutGesture = true;
  
  /// Enable zoom controls
  static const bool enableZoom = false;
  
  // ========== SPLASH SCREEN CONFIGURATION ==========
  
  /// Splash screen duration in seconds
  static const int splashDurationSeconds = 3;
  
  /// Splash screen background color (hex)
  static const String splashBackgroundColor = '#1A1147';
  
  // ========== UI CONFIGURATION ==========
  
  /// Primary color for the app (deep indigo night sky)
  static const int primaryColorValue = 0xFF1A1147;

  /// Accent color (golden star)
  static const int accentColorValue = 0xFFFFC107;
  
  /// Progress indicator color
  static const int progressIndicatorColor = 0xFFFFC107;
  
  /// Show app bar in WebView screen
  static const bool showAppBar = false;
  
  // ========== OFFLINE PAGE CONFIGURATION ==========
  
  /// Offline page title
  static const String offlineTitle = 'No Internet Connection';
  
  /// Offline page message
  static const String offlineMessage = 
      'Please check your internet connection and try again.';
  
  /// Retry button text
  static const String retryButtonText = 'Retry';
  
  // ========== EXTERNAL LINK HANDLING ==========
  
  /// Domains that should open in WebView (same domain)
  /// Links from other domains will open in system browser
  static List<String> allowedDomains = [
    'bishnuprasadchundali.com.np',
    'www.bishnuprasadchundali.com.np',
  ];
  
  /// Enable external browser for external links
  static const bool openExternalLinksInBrowser = true;
  
  // ========== PERFORMANCE SETTINGS ==========
  
  /// Enable pull to refresh
  static const bool enablePullToRefresh = true;
  
  /// Enable iOS swipe back gesture
  static const bool enableIOSSwipeBack = true;
  
  /// Clear cache on app start
  static const bool clearCacheOnStart = false;
  
  // ========== PRODUCTION SETTINGS ==========
  
  /// Enable analytics (set to false in debug builds)
  static const bool enableAnalytics = true;
  
  /// Enable crash reporting
  static const bool enableCrashReporting = true;
  
  /// Enable logging
  static const bool enableLogging = true;
  
  /// User Agent for WebView
  static String get userAgent => 
      'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) '
      'AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 '
      '$appName/$appVersion';
  
  // ========== CACHE SETTINGS ==========
  
  /// Maximum cache age in days
  static const int maxCacheAgeDays = 7;
  
  /// Maximum cache size in MB
  static const int maxCacheSizeMB = 100;
  
  /// Enable offline caching
  static const bool enableOfflineCache = false;
}
