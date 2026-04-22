import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Connectivity Service
/// 
/// Monitors internet connectivity status and provides real-time updates.
/// Uses connectivity_plus package for cross-platform connectivity detection.
class ConnectivityService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  
  bool _isOnline = true;
  
  /// Returns current connectivity status
  bool get isOnline => _isOnline;
  
  ConnectivityService() {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }
  
  /// Initialize connectivity check
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      _isOnline = false;
      notifyListeners();
    }
  }
  
  /// Update connection status based on connectivity result
  void _updateConnectionStatus(ConnectivityResult result) {
    // Consider the device online if any connection type is available
    final wasOnline = _isOnline;
    _isOnline = result != ConnectivityResult.none;
    
    // Only notify listeners if status changed
    if (wasOnline != _isOnline) {
      debugPrint('Connectivity changed: ${_isOnline ? "Online" : "Offline"}');
      notifyListeners();
    }
  }
  
  /// Check current connectivity status
  Future<bool> checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      return false;
    }
  }
  
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
