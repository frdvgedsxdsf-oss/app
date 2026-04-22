import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_config.dart';
import '../widgets/loading_indicator.dart';

/// Mobile WebView Screen
/// 
/// Production-ready WebView implementation for iOS/Android
/// Includes proper error handling, progress tracking, and security settings
class MobileWebViewScreen extends StatefulWidget {
  const MobileWebViewScreen({super.key});

  @override
  State<MobileWebViewScreen> createState() => _MobileWebViewScreenState();
}

class _MobileWebViewScreenState extends State<MobileWebViewScreen> 
    with WidgetsBindingObserver {
  late final WebViewController _controller;
  double _loadingProgress = 0.0;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeWebView();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle for better resource management
    if (state == AppLifecycleState.paused) {
      // App is in background - pause any active content
      _controller.runJavaScript('if(typeof pauseMedia === "function") pauseMedia();');
    } else if (state == AppLifecycleState.resumed) {
      // App is back - refresh if needed
      _controller.reload();
    }
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(
        AppConfig.enableJavaScript 
            ? JavaScriptMode.unrestricted 
            : JavaScriptMode.disabled,
      )
      ..setBackgroundColor(Colors.white)
      ..setUserAgent(
        'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 ${AppConfig.appName}/${AppConfig.appVersion}',
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                _loadingProgress = progress / 100;
                _isLoading = progress < 100;
              });
            }
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _hasError = false;
                _isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _loadingProgress = 1.0;
              });
            }
            
            // Inject CSS for better mobile experience
            _controller.runJavaScript('''
              (function() {
                var meta = document.createElement('meta');
                meta.name = 'viewport';
                meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes';
                document.head.appendChild(meta);
                
                // Smooth scrolling
                document.documentElement.style.scrollBehavior = 'smooth';
                document.documentElement.style.webkitOverflowScrolling = 'touch';
              })();
            ''');
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                _hasError = true;
                _isLoading = false;
                _errorMessage = error.description;
              });
            }
            debugPrint('WebView Error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            final uri = Uri.parse(request.url);
            
            // Check if URL is from allowed domains
            if (AppConfig.openExternalLinksInBrowser) {
              final isAllowedDomain = AppConfig.allowedDomains.any(
                (domain) => uri.host.contains(domain),
              );
              
              if (!isAllowedDomain) {
                // Open external links in system browser
                _launchExternalUrl(request.url);
                return NavigationDecision.prevent;
              }
            }
            
            return NavigationDecision.navigate;
          },
        ),
      )
      ..enableZoom(AppConfig.enableZoom)
      ..loadRequest(Uri.parse(AppConfig.websiteUrl));
  }

  Future<void> _launchExternalUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      if (mounted) {
        _showErrorSnackBar('Could not open link: $url');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _hasError = false;
      _isLoading = true;
    });
    await _controller.reload();
  }

  Future<bool> _handleBackNavigation() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return false; // Don't exit app
    }
    return true; // Exit app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackNavigation,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppConfig.showAppBar
            ? AppBar(
                title: Text(
                  AppConfig.appName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: const Color(AppConfig.primaryColorValue),
                foregroundColor: Colors.white,
                elevation: 0,
                actions: [
                  // Refresh button
                  IconButton(
                    icon: const Icon(CupertinoIcons.refresh),
                    onPressed: _handleRefresh,
                    tooltip: 'Refresh',
                  ),
                ],
              )
            : null,
        body: SafeArea(
          child: Stack(
            children: [
              // WebView
              if (!_hasError)
                WebViewWidget(controller: _controller),
              
              // Error state
              if (_hasError)
                _buildErrorView(),
              
              // Loading indicator
              if (_isLoading && !_hasError)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LoadingIndicator(progress: _loadingProgress),
                ),
            ],
          ),
        ),
        // Pull to refresh (iOS style)
        floatingActionButton: !AppConfig.showAppBar && !_isLoading
            ? null
            : null,
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 80,
              color: Colors.orange[400],
            ),
            const SizedBox(height: 24),
            const Text(
              'Unable to Load Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage.isEmpty
                  ? 'Please check your connection and try again.'
                  : _errorMessage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CupertinoButton.filled(
              onPressed: _handleRefresh,
              child: const Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                _launchExternalUrl(AppConfig.websiteUrl);
              },
              child: const Text('Open in Browser'),
            ),
          ],
        ),
      ),
    );
  }
}
