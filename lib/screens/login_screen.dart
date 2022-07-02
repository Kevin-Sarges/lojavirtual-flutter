import 'package:flutter/material.dart';
import 'package:k3loja/screens/singup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final SizedBox _sizedBox = const SizedBox(height: 16);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SingupScreen()));
            },
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'E-mail',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text!.isEmpty || !text.contains('@')) {
                  return 'E-mail invalido !!';
                }
                return null;
              },
            ),
            _sizedBox,
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Senha',
              ),
              obscureText: true,
              validator: (text) {
                if (text!.isEmpty || text.length < 6) {
                  return 'Senha invalida !!';
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Esqueci a senha',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            _sizedBox,
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
