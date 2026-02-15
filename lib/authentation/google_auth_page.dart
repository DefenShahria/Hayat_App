import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller/google_auth_controller.dart';

class GoogleAuthPage extends StatefulWidget {
  const GoogleAuthPage({super.key});

  @override
  State<GoogleAuthPage> createState() => _GoogleAuthPageState();
}

class _GoogleAuthPageState extends State<GoogleAuthPage>
    with TickerProviderStateMixin {
  late final GoogleAuthController _authController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<GoogleAuthController>();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red.shade50,
              Colors.blue.shade50,
              Colors.red.shade100.withOpacity(0.5),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40,
              ),
              child: FadeTransition(
                opacity: _fadeController,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_slideController),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // Animated Logo
                      ScaleTransition(
                        scale: Tween<double>(begin: 0.95, end: 1.05).animate(
                          CurvedAnimation(
                            parent: _pulseController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.red.shade400,
                                Colors.red.shade600,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.bloodtype,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.red.shade600, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'Hayat',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: 48,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Save Lives, Share Life',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 60),

                      _buildFeatureCard(
                        icon: Icons.favorite,
                        title: 'Save Lives',
                        description: 'Connect blood donors with those in need',
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureCard(
                        icon: Icons.location_on,
                        title: 'Find Nearby',
                        description: 'Locate donors and hospitals near you',
                        color: Colors.blue,
                      ),

                      const SizedBox(height: 80),

                      // Refined Google Sign-In Button
                      GetBuilder<GoogleAuthController>(
                        builder: (controller) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: controller.isLoading
                                    ? null
                                    : () =>
                                          _authController.signInWithGoogle(context),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: controller.isLoading 
                                          ? Colors.red.shade200 
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: controller.isLoading
                                      ? Center(
                                          child: SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                Colors.red.shade600,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/google_logo.png',
                                              height: 24,
                                              width: 24,
                                              errorBuilder: (_, __, ___) =>
                                                  const Icon(Icons.language, color: Colors.blue),
                                            ),
                                            const SizedBox(width: 14),
                                            Text(
                                              'Continue with Google',
                                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              if (controller.isLoading)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    'Securely signing you in...',
                                    style: TextStyle(
                                      color: Colors.red.shade600,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 60),

                      Text(
                        'By continuing, you agree to our\nTerms of Service and Privacy Policy',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade500,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Icon(icon, color: color, size: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
