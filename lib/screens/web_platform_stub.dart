/// Stub implementation used on non-web platforms (iOS, Android, desktop).
///
/// On native platforms we never open the site in a browser window, so these
/// helpers are no-ops. The real implementation lives in `web_platform_web.dart`
/// and is selected via a conditional import in `webview_screen.dart`.
library;

void redirectTopLevel(String url) {
  // No-op on native platforms.
}

void reloadPage() {
  // No-op on native platforms.
}
