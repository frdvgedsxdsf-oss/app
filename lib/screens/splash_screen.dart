import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import '../config/app_config.dart';
import 'webview_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _rotationController;
  late AnimationController _twinkleController;

  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;

  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  static const Color _bgTop = Color(0xFF1A1147);
  static const Color _bgBottom = Color(0xFF2B0A4A);
  static const Color _gold = Color(0xFFFFC107);
  static const Color _goldSoft = Color(0xFFFFD54F);

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );
    _logoFadeAnimation = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.9, curve: Curves.elasticOut),
      ),
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _textFadeAnimation =
        CurvedAnimation(parent: _textController, curve: Curves.easeIn);
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    _rotationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();

    _twinkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _startAnimations();

    Timer(
      Duration(seconds: AppConfig.splashDurationSeconds),
      _navigateToWebView,
    );
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _textController.forward();
  }

  void _navigateToWebView() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WebViewScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _rotationController.dispose();
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_bgTop, _bgBottom],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _twinkleController,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _StarFieldPainter(
                        twinkle: _twinkleController.value,
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    FadeTransition(
                      opacity: _logoFadeAnimation,
                      child: ScaleTransition(
                        scale: _logoScaleAnimation,
                        child: Hero(
                          tag: 'app-logo',
                          child: SizedBox(
                            width: 220,
                            height: 220,
                            child: AnimatedBuilder(
                              animation: _rotationController,
                              builder: (context, _) {
                                return CustomPaint(
                                  painter: _SunEmblemPainter(
                                    rotation:
                                        _rotationController.value * 2 * math.pi,
                                    glow: _twinkleController.value,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    SlideTransition(
                      position: _textSlideAnimation,
                      child: FadeTransition(
                        opacity: _textFadeAnimation,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const _Diamond(size: 12),
                                const SizedBox(width: 14),
                                Text(
                                  AppConfig.appName.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color: _gold,
                                    letterSpacing: 4.0,
                                    shadows: [
                                      Shadow(
                                        color: Color(0x66FFC107),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 14),
                                const _Diamond(size: 12),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              height: 1,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Color(0x99FFC107),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              AppConfig.appNameLocal,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.92),
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              '\u2728  ${AppConfig.appTagline}  \u2728',
                              style: TextStyle(
                                fontSize: 13,
                                color: _goldSoft.withOpacity(0.85),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 5),
                  ],
                ),
              ),
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                    '\u00a9 ${AppConfig.appName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.45),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Diamond extends StatelessWidget {
  final double size;
  const _Diamond({required this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFFFFC107),
          borderRadius: BorderRadius.circular(2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66FFC107),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class _StarFieldPainter extends CustomPainter {
  final double twinkle;
  _StarFieldPainter({required this.twinkle});

  static final List<Offset> _stars = List.generate(60, (i) {
    final rnd = math.Random(i * 977 + 13);
    return Offset(rnd.nextDouble(), rnd.nextDouble());
  });

  static const List<Offset> _sparkles = [
    Offset(0.06, 0.05),
    Offset(0.93, 0.06),
    Offset(0.12, 0.13),
    Offset(0.88, 0.14),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint();
    for (var i = 0; i < _stars.length; i++) {
      final s = _stars[i];
      final phase = (twinkle + i * 0.07) % 1.0;
      final opacity =
          0.15 + 0.35 * (0.5 + 0.5 * math.sin(phase * 2 * math.pi));
      dotPaint.color = Colors.white.withOpacity(opacity);
      final radius = 0.6 + (i % 3) * 0.5;
      canvas.drawCircle(
        Offset(s.dx * size.width, s.dy * size.height * 0.75),
        radius,
        dotPaint,
      );
    }

    for (var i = 0; i < _sparkles.length; i++) {
      final p = _sparkles[i];
      final center = Offset(p.dx * size.width, p.dy * size.height);
      final phase = (twinkle + i * 0.25) % 1.0;
      final scale = 0.7 + 0.5 * math.sin(phase * 2 * math.pi);
      _drawSparkle(
        canvas,
        center,
        8 * scale,
        const Color(0xFFFFC107).withOpacity(0.8),
      );
    }
  }

  void _drawSparkle(Canvas canvas, Offset c, double r, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(c.dx, c.dy - r)
      ..lineTo(c.dx + r * 0.25, c.dy - r * 0.25)
      ..lineTo(c.dx + r, c.dy)
      ..lineTo(c.dx + r * 0.25, c.dy + r * 0.25)
      ..lineTo(c.dx, c.dy + r)
      ..lineTo(c.dx - r * 0.25, c.dy + r * 0.25)
      ..lineTo(c.dx - r, c.dy)
      ..lineTo(c.dx - r * 0.25, c.dy - r * 0.25)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _StarFieldPainter old) =>
      old.twinkle != twinkle;
}

class _SunEmblemPainter extends CustomPainter {
  final double rotation;
  final double glow;
  _SunEmblemPainter({required this.rotation, required this.glow});

  static const Color _gold = Color(0xFFFFC107);
  static const Color _darkGold = Color(0xFFB8860B);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerR = size.width / 2;

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = _gold.withOpacity(0.55);
    canvas.drawCircle(center, outerR - 2, ringPaint);

    ringPaint
      ..strokeWidth = 0.8
      ..color = _gold.withOpacity(0.35);
    canvas.drawCircle(center, outerR - 14, ringPaint);

    final discR = outerR * 0.62;
    final discPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _darkGold.withOpacity(0.55),
          _darkGold.withOpacity(0.15),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: discR));
    canvas.drawCircle(center, discR, discPaint);

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _gold.withOpacity(0.35 + 0.15 * glow),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: discR * 0.9));
    canvas.drawCircle(center, discR * 0.9, glowPaint);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    final starOuter = discR * 0.72;
    final starInner = discR * 0.28;
    final starPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFE082), _gold],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: starOuter));

    final path = Path();
    const points = 8;
    for (var i = 0; i < points * 2; i++) {
      final isOuter = i.isEven;
      final r = isOuter ? starOuter : starInner;
      final angle = (i * math.pi) / points - math.pi / 2;
      final x = math.cos(angle) * r;
      final y = math.sin(angle) * r;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, starPaint);

    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _darkGold.withOpacity(0.7);
    canvas.drawPath(path, outlinePaint);

    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset.zero, starInner * 0.35, dotPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SunEmblemPainter old) =>
      old.rotation != rotation || old.glow != glow;
}
