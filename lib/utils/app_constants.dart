/// App Constants
/// 
/// Production-ready constants for the application
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // ========== URL PATTERNS ==========
  static const String httpPattern = r'https?:\/\/(www\.)?';
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[\d\s\-\(\)]+$';

  // ========== TIMEOUT DURATIONS ==========
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration splashMinDuration = Duration(seconds: 2);
  static const Duration debounceTime = Duration(milliseconds: 500);

  // ========== CACHE SETTINGS ==========
  static const int maxCacheAge = 7; // days
  static const int maxCacheSize = 100; // MB

  // ========== UI CONSTANTS ==========
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double iconSize = 24.0;
  static const double buttonHeight = 48.0;

  // ========== ANIMATION DURATIONS ==========
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // ========== ERROR MESSAGES ==========
  static const String networkErrorMessage = 
      'Unable to connect. Please check your internet connection.';
  static const String timeoutErrorMessage = 
      'Request timed out. Please try again.';
  static const String genericErrorMessage = 
      'Something went wrong. Please try again later.';
  static const String permissionDeniedMessage = 
      'Permission denied. Please enable it in Settings.';

  // ========== SUCCESS MESSAGES ==========
  static const String refreshSuccessMessage = 'Refreshed successfully';
  static const String loadSuccessMessage = 'Loaded successfully';

  // ========== APP STORE INFO ==========
  static const String appStoreId = ''; // Add your App Store ID
  static const String playStoreId = ''; // Add your Play Store ID
  
  // ========== SUPPORT INFO ==========
  static const String supportEmail = 'info@bishnuprasadchundali.com.np';
  static const String supportPhone = '';
  static const String websiteUrl = 'https://bishnuprasadchundali.com.np';
  
  // ========== SOCIAL MEDIA ==========
  static const String facebookUrl = '';
  static const String instagramUrl = '';
  static const String twitterUrl = '';
}
