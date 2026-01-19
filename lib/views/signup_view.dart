import 'package:flutter/material.dart';
import 'package:make_plan/views/login_view.dart';
import 'package:make_plan/views/main_view.dart';
import 'package:make_plan/widgets/auth/auth_button.dart';
import 'package:make_plan/widgets/auth/auth_header.dart';
import 'package:make_plan/widgets/auth/auth_switch_text.dart';
import 'package:make_plan/widgets/auth/auth_text_field.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_provider.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(
                  title: "Create Account ✨",
                  subtitle: "Start planning your goals",
                ),
                const SizedBox(height: 40),

                // ---------------- EMAIL ----------------
                AuthTextField(
                  controller: emailCtrl,
                  hint: "Email",
                ),
                const SizedBox(height: 16),

                // ---------------- PASSWORD ----------------
                AuthTextField(
                  controller: passCtrl,
                  hint: "Password",
                  obscure: true,
                ),
                const SizedBox(height: 16),

                // ---------------- CONFIRM PASSWORD ----------------
                AuthTextField(
                  controller: confirmCtrl,
                  hint: "Confirm Password",
                  obscure: true,
                ),
                const SizedBox(height: 30),

                // ---------------- SIGN UP BUTTON ----------------
                AuthButton(
                  text: "Sign Up",
                  loading: auth.isLoading,
                  onTap: () async {
                    final email = emailCtrl.text.trim();
                    final password = passCtrl.text.trim();
                    final confirm = confirmCtrl.text.trim();

                    // 1. EMPTY CHECK
                    if (email.isEmpty ||
                        password.isEmpty ||
                        confirm.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please fill all fields")),
                      );
                      return;
                    }

                    // 2. EMAIL FORMAT CHECK
                    final emailRegex =
                        RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!emailRegex.hasMatch(email)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Enter a valid email address")),
                      );
                      return;
                    }

                    // 3. PASSWORD MATCH CHECK
                    if (password != confirm) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    // 4. PASSWORD LENGTH CHECK
                    if (password.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Password must be at least 6 characters")),
                      );
                      return;
                    }

                    // 5. CALL SUPABASE SIGNUP
                    try {
                      await auth.signup(email, password);

                      // 6. NAVIGATE ONLY IF SUCCESS
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MainView()),
                      );
                    } catch (e) {
                      // 7. SHOW ERROR INSTEAD OF CRASH
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString().replaceAll('Exception: ', ''),
                          ),
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),

                // ---------------- SWITCH TO LOGIN ----------------
                AuthSwitchText(
                  text: "Already have an account?",
                  actionText: "Login",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
