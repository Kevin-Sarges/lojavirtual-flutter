import 'package:flutter/material.dart';

class SingupScreen extends StatelessWidget {
  SingupScreen({Key? key}) : super(key: key);

  final SizedBox _sizedBox = const SizedBox(height: 16);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nome completo',
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Nome inválido !!';
                }
                return null;
              },
            ),
            _sizedBox,
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'E-mail',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text!.isEmpty || !text.contains('@')) {
                  return 'E-mail inválido !!';
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
                  return 'Senha inválida !!';
                }
                return null;
              },
            ),
            _sizedBox,
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Seu endereço',
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Endeço inválido !!';
                }
                return null;
              },
            ),
            _sizedBox,
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: const Text(
                  'Criar Conta',
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
