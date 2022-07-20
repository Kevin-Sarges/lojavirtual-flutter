import 'package:flutter/material.dart';
import 'package:k3loja/screens/home_screen.dart';
import 'package:k3loja/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:k3loja/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SizedBox _sizedBoxHeight = const SizedBox(height: 50);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggerIn();

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  final Widget _buildBodyBack = Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF048D5C),
          Color(0xFF047D8D),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBodyBack,
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Loja virtual',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _sizedBoxHeight,
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                _sizedBoxHeight,
                const CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
