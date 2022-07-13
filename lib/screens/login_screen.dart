import 'package:flutter/material.dart';
import 'package:k3loja/providers/auth_provider.dart';
import 'package:k3loja/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SizedBox _sizedBoxHeight = const SizedBox(height: 50);
  final SizedBox _sizedBoxWidth = const SizedBox(width: 15);

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
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkSignedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Login falhou !!');
        break;

      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Login cancelado !!');
        break;

      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Logado com sucesso !!');
        break;
      default:
        break;
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          _buildBodyBack,
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
            ),
            children: [
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _sizedBoxHeight,
              const Image(
                image: AssetImage('assets/images/user.png'),
                width: 200,
                height: 200,
              ),
              _sizedBoxHeight,
              ElevatedButton(
                onPressed: () async {
                  bool isSuccess = await authProvider.handleGoogleSignIn();

                  if (isSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  onPrimary: Colors.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/search.png'),
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    _sizedBoxWidth,
                    const Text(
                      'Google',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: authProvider.status == Status.authenticating
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
