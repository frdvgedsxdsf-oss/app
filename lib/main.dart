import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'config/app_config.dart';
import 'services/connectivity_service.dart';
import 'screens/splash_screen.dart';

/// Main Entry Point
/// 
/// Initializes the Flutter app with iOS-optimized settings and providers.
void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Production error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // In production, you can log to crash reporting service here
    debugPrint('Flutter Error: ${details.exception}');
  };
  
  // Set status bar style: dark background (Divya Jyotish) -> light icons
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark, // iOS: dark BG -> light content
      statusBarIconBrightness: Brightness.light, // Android: light icons
    ),
  );
  
  // Lock orientation to portrait mode (optional)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MyApp());
}

/// Root App Widget
/// 
/// Provides dependency injection and configures app-wide settings.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Connectivity service for offline detection
        ChangeNotifierProvider(
          create: (_) => ConnectivityService(),
        ),
      ],
      child: MaterialApp(
        // App Info
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        
        // Theme Configuration
        theme: ThemeData(
          // Primary color
          primarySwatch: _createMaterialColor(
            const Color(AppConfig.primaryColorValue),
          ),
          primaryColor: const Color(AppConfig.primaryColorValue),
          
          // iOS-style design
          platform: TargetPlatform.iOS,
          
          // Typography
          fontFamily: '.SF Pro Text', // iOS default font
          
          // App Bar Theme
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Color(AppConfig.primaryColorValue),
            foregroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          
          // Cupertino overrides for iOS feel
          cupertinoOverrideTheme: const CupertinoThemeData(
            primaryColor: Color(AppConfig.primaryColorValue),
            barBackgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
          ),
          
          // Visual Density
          visualDensity: VisualDensity.adaptivePlatformDensity,
          
          // Progress Indicator Theme
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(AppConfig.progressIndicatorColor),
          ),
        ),
        
        // Initial Route
        home: const SplashScreen(),
        
        // Route Configuration
        routes: {
          '/splash': (context) => const SplashScreen(),
        },
      ),
    );
  }
  
  /// Create MaterialColor from a single color
  /// This is required for primarySwatch in ThemeData
  MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = <double>[
      .05, .1, .2, .3, .4, .5, .6, .7, .8, .9,
    ];
    
    Map<int, Color> swatch = {};
    final int r = color.red;
    final int g = color.green;
    final int b = color.blue;
    
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    
    return MaterialColor(color.value, swatch);
  }
}
