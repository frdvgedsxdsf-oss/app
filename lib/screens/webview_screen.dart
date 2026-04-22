import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../config/app_config.dart';
import '../services/connectivity_service.dart';
import '../widgets/offline_page.dart';
import 'mobile_webview_screen.dart';

// Platform helpers. `dart:html` is only referenced on the web through this
// conditional import so iOS/Android builds compile cleanly.
import 'web_platform_stub.dart'
    if (dart.library.html) 'web_platform_web.dart' as platform;

/// WebView Screen
///
/// On native (iOS/Android) it embeds the site in an in-app WebView.
/// On Flutter Web it redirects the browser to the target URL so cookies
/// work as first-party.
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool _redirected = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_redirected) {
          _redirected = true;
          platform.redirectTopLevel(AppConfig.websiteUrl);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityService>(
      builder: (context, connectivityService, child) {
        if (!connectivityService.isOnline) {
          return OfflinePage(
            onRetry: () async {
              final isOnline = await connectivityService.checkConnectivity();
              if (isOnline && kIsWeb) {
                platform.reloadPage();
              }
            },
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppConfig.showAppBar
              ? AppBar(
                  title: const Text(AppConfig.appName),
                  backgroundColor: const Color(AppConfig.primaryColorValue),
                  foregroundColor: Colors.white,
                  elevation: 0,
                )
              : null,
          body: SafeArea(
            child: kIsWeb
                ? const _WebRedirectingView()
                : const MobileWebViewScreen(),
          ),
        );
      },
    );
  }
}

/// Placeholder shown on Flutter Web while the browser redirects.
class _WebRedirectingView extends StatelessWidget {
  const _WebRedirectingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1147),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFC107)),
          ),
          const SizedBox(height: 24),
          Text(
            'Opening ${AppConfig.appName}...',
            style: const TextStyle(
              color: Color(0xFFFFC107),
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
