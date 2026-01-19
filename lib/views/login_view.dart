import 'package:flutter/material.dart';
import 'package:make_plan/views/main_view.dart';
import 'package:make_plan/widgets/auth/auth_button.dart';
import 'package:make_plan/widgets/auth/auth_header.dart';
import 'package:make_plan/widgets/auth/auth_switch_text.dart';
import 'package:make_plan/widgets/auth/auth_text_field.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_provider.dart';
import 'signup_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: "Welcome Back 👋",
                subtitle: "Login to continue planning",
              ),
              const SizedBox(height: 40),

              AuthTextField(
                controller: emailCtrl,
                hint: "Email",
              ),
              const SizedBox(height: 16),

              AuthTextField(
                controller: passCtrl,
                hint: "Password",
                obscure: true,
              ),
              const SizedBox(height: 30),

             AuthButton(
  text: "Login",
  loading: auth.isLoading,
  onTap: () async {
    if (emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    await auth.login(
      emailCtrl.text,
      passCtrl.text,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainView()),
    );
  },
),


              const SizedBox(height: 20),

              AuthSwitchText(
                text: "Don’t have an account?",
                actionText: "Sign up",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignupView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
