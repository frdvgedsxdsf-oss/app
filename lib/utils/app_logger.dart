import 'package:flutter/foundation.dart';

/// App Logger
/// 
/// Centralized logging utility for production apps
/// In production, this can be connected to crash reporting services
class AppLogger {
  static const String _appTag = 'A-One App';

  /// Log info message
  static void info(String message, [String? tag]) {
    if (kDebugMode) {
      debugPrint('[$_appTag${tag != null ? " - $tag" : ""}] INFO: $message');
    }
  }

  /// Log warning message
  static void warning(String message, [String? tag]) {
    if (kDebugMode) {
      debugPrint('[$_appTag${tag != null ? " - $tag" : ""}] WARNING: $message');
    }
  }

  /// Log error message
  static void error(String message, [dynamic error, StackTrace? stackTrace, String? tag]) {
    if (kDebugMode) {
      debugPrint('[$_appTag${tag != null ? " - $tag" : ""}] ERROR: $message');
      if (error != null) {
        debugPrint('Error details: $error');
      }
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }
    
    // In production, send to crash reporting service
    // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  /// Log network request
  static void network(String method, String url, [int? statusCode]) {
    if (kDebugMode) {
      final status = statusCode != null ? ' - Status: $statusCode' : '';
      debugPrint('[$_appTag - Network] $method $url$status');
    }
  }

  /// Log analytics event
  static void analytics(String event, [Map<String, dynamic>? parameters]) {
    if (kDebugMode) {
      debugPrint('[$_appTag - Analytics] Event: $event${parameters != null ? ", Params: $parameters" : ""}');
    }
    
    // In production, send to analytics service
    // Example: FirebaseAnalytics.instance.logEvent(name: event, parameters: parameters);
  }
}
