import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme; // fungsi toggle theme
  final bool isDark; // status theme (true/false)

  const SplashScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _waveControllerFront;
  late AnimationController _waveControllerBack;
  late AnimationController _sunController;
  late AnimationController _parallaxController;

  @override
  void initState() {
    super.initState();

    // 🌊 Dua ombak dengan kecepatan berbeda
    _waveControllerFront = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _waveControllerBack = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat(reverse: true);

    // ☀️ Matahari bergerak kiri → kanan
    _sunController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..forward();

    // 🎢 Parallax untuk efek goyangan seluruh elemen
    _parallaxController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    // ⏱️ Navigasi otomatis ke dashboard
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DashboardPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fade = Tween(begin: 0.0, end: 1.0).animate(animation);
          final slide = Tween(begin: const Offset(0, 1), end: Offset.zero)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 900),
      ));
    });
  }

  @override
  void dispose() {
    _waveControllerFront.dispose();
    _waveControllerBack.dispose();
    _sunController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _waveControllerFront,
          _waveControllerBack,
          _sunController,
          _parallaxController
        ]),
        builder: (context, child) {
          // 🔁 Parallax offset
          double parallaxOffset = 8 * math.sin(_parallaxController.value * 2 * math.pi);

          return Stack(
            children: [
              // 🌈 Gradasi langit
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: widget.isDark
                        ? [
                            const Color(0xFF1a237e),
                            const Color(0xFF283593),
                            const Color(0xFF3949ab),
                          ]
                        : [
                            const Color(0xFF87CEFA),
                            const Color(0xFF00B4DB),
                            Colors.white,
                          ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),

              // ☀️ Matahari bergerak kiri → kanan (dengan sedikit goyangan parallax)
              Positioned(
                top: 150 - 40 * math.sin(_sunController.value * math.pi),
                left: (_sunController.value * screenWidth) - 50 + parallaxOffset,
                child: Transform.scale(
                  scale: 1.0 + 0.02 * math.sin(_parallaxController.value * 2 * math.pi),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Colors.yellowAccent, Colors.orangeAccent],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange,
                          blurRadius: 25,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 🌊 Ombak belakang (gerakan lambat)
              Positioned(
                bottom: 0,
                left: parallaxOffset * -0.5, // sedikit offset parallax
                right: 0,
                child: ClipPath(
                  clipper: WaveClipperOne(reverse: true),
                  child: Container(
                    height: 220 - (10 * _waveControllerBack.value),
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),

              // 🌊 Ombak depan (gerakan cepat)
              Positioned(
                bottom: 0,
                left: parallaxOffset, // efek parallax lebih kuat di ombak depan
                right: 0,
                child: ClipPath(
                  clipper: WaveClipperTwo(flip: true),
                  child: Container(
                    height: 240 + (10 * _waveControllerFront.value),
                    color: Colors.white.withOpacity(0.35),
                  ),
                ),
              ),

              // 💫 Konten tengah
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage('assets/PP.jpg'),
                      ),
                    ),
                    const SizedBox(height: 25),

                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [Colors.white, Colors.lightBlueAccent, Colors.white],
                        ).createShader(bounds);
                      },
                      child: const Text(
                        "My App",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      " Rhestu Dzulkifli - 152022164",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),

              // 🌙 Tombol ganti tema
              Positioned(
                top: 50,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    widget.isDark ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: widget.onToggleTheme,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
