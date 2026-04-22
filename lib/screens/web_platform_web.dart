/// Web-only implementation of platform helpers.
///
/// This file is selected via the conditional import in `webview_screen.dart`
/// when the app is compiled for the web. It must never be imported on
/// native platforms (iOS/Android) because `dart:html` is not available there.
library;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void redirectTopLevel(String url) {
  html.window.location.href = url;
}

void reloadPage() {
  html.window.location.reload();
}
