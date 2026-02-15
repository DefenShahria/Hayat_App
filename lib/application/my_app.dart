import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../Bottom_Navigationbar/bottom_navigationBar.dart';
import '../authentation/google_auth_page.dart';
import '../core/utils/controller_binding.dart';
import 'app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hayat',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show loading while checking auth state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // If user is signed in, go to home
          if (snapshot.hasData) {
            return const BottomNavBar();
          }
          // Otherwise show auth page
          return const GoogleAuthPage();
        },
      ),
    );
  }
}
