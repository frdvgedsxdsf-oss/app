import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../config/app_config.dart';

/// Offline Page Widget
/// 
/// Displays when there's no internet connection.
/// Includes an icon, message, and retry button.
class OfflinePage extends StatelessWidget {
  final VoidCallback onRetry;
  
  const OfflinePage({
    super.key,
    required this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Offline Icon
                Icon(
                  CupertinoIcons.wifi_slash,
                  size: 100,
                  color: Colors.grey[400],
                ),
                
                const SizedBox(height: 32),
                
                // Title
                Text(
                  AppConfig.offlineTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                // Message
                Text(
                  AppConfig.offlineMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 48),
                
                // Retry Button - iOS Style
                CupertinoButton.filled(
                  onPressed: onRetry,
                  child: const Text(
                    AppConfig.retryButtonText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
