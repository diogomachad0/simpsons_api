import 'package:flutter/material.dart';
import 'package:untitled2/screens/screens_autenticacoes/register_screen.dart';
import 'package:untitled2/services/autenticacao_service/auth_service.dart';

import 'package:untitled2/widgets/custom_input.dart';
import 'package:untitled2/widgets/custom_input_password.dart';
import 'package:untitled2/widgets/custom_loading.dart';
import 'package:untitled2/widgets/error_auth.dart';

class LoginScreen extends StatelessWidget {
  final AuthService authService;

  const LoginScreen({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Image.asset('assets/img/the.png'),
            CustomInput(
              controller: authService.emailController,
              textInputType: TextInputType.emailAddress,
              label: 'Email',
              hintText: 'Email',
            ),
            CustomInputPassword(
              controller: authService.passwordController,
              textInputType: TextInputType.visiblePassword,
              label: 'Password',
              hintText: 'Password',
            ),
            ErrorAuth(
              listenable: authService.isErrorGeneric,
              messageError: "Um problema ocorreu",
            ),
            ErrorAuth(
              listenable: authService.isErrorCredential,
              messageError: "Suas credenciais estão invalidas",
            ),
            CustomLoading(
              listenable: authService.isLoading,
              textButton: "Login",
              action: () {
                authService.login(context);
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RegisterScreen(authService: authService),
                  ),
                );
              },
              child: const Text(
                "Cadastre-se",
                style: TextStyle(color: Colors.amber),
              ),
            )
          ],
        ),
      ),
    );
  }
}
