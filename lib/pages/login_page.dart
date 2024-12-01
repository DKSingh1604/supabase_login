import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_login/auth/auth_service.dart';
import 'package:supabase_login/pages/profile_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //get auth service
  final authService = AuthService();

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login button pressed
  void login() async {
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;

    //attempt login
    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        onLogin: (loginData) async {
          final email = loginData.name ?? '';
          final password = loginData.password ?? '';

          try {
            await authService.signInWithEmailPassword(email, password);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Successfull!'),
              ),
            );
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: $e"),
                ),
              );
            }
          }
        },
        onSignup: (signupData) async {
          try {
            await authService.signUpWithEmailPassword(
                signupData.name ?? '', signupData.password ?? '');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign Up Successfull!'),
              ),
            );
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: $e"),
                ),
              );
            }
          }
        },
        onRecoverPassword: (String email) async {
          return 'Password recovery is not implemented yet.';
        },
        onSubmitAnimationCompleted: () {
          try {
            // Verify if the session is valid
            final session = Supabase.instance.client.auth.currentSession;

            if (session != null && session.user != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            } else {
              // Show error message if session is invalid
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Login failed. Please check your credentials.'),
                  ),
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $e'),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
