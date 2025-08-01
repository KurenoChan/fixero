import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fixero/pages/intro/intro_page.dart';
import 'package:fixero/pages/main/home_page.dart';
import 'package:fixero/pages/main/inventory_page.dart';
import 'package:fixero/pages/main/login_page.dart';
import 'package:fixero/theme/dark_mode.dart';
import 'package:fixero/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'firebase_options.dart';

void main() async {
  // Initialize Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Google Sign-In
  await GoogleSignIn.instance.initialize();

  // Get SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();
  final seenIntro = prefs.getBool('seenIntro') ?? false;
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MainApp(seenIntro: seenIntro, isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool seenIntro;
  final bool isLoggedIn;

  const MainApp({super.key, required this.seenIntro, required this.isLoggedIn});

  Widget _getNextScreen() {
    if (!seenIntro) {
      return const IntroPage();
    } else if (!isLoggedIn) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,

      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        InventoryPage.routeName: (_) => const InventoryPage(),
      },

      home: AnimatedSplashScreen(
        splash: 'assets/images/logo/splash_fixero.gif',
        splashIconSize: 2000.0,
        centered: true,
        nextScreen: _getNextScreen(),
        backgroundColor: Colors.black,
        duration: 4000,
      ),
    );
  }
}
