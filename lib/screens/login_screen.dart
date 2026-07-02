import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodgo_app_test/bloc/auth/auth_bloc.dart';
import 'package:foodgo_app_test/bloc/auth/auth_event.dart';
import 'package:foodgo_app_test/bloc/auth/auth_state.dart';

import 'package:foodgo_app_test/config/app_config.dart';
import 'package:foodgo_app_test/widgets/cusomtextfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formkey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      AuthLoginRequested(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(AppColors.background),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 27,
                                  color: Color(0xFFF9C80E),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2B2D42),
                                ),
                              ),
                              SizedBox(height: 24),
                  
                              Text(
                                'E-mail',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF2B2D42),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              CustomTextFormField(
                                hintText: 'Enter your email',
                  
                                obscureText: false,
                                controller: emailController,
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!v.contains('@') || !v.contains('.')) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              Text(
                                'password',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF2B2D42),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                  
                              CustomTextFormField(
                                hintText: 'Enter your password',
                                obscureText: true,
                                controller: passwordController,
                                suffixIcon: Image.asset('assets/images/eye.png'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Minimum 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12),
                              TextButton(
                                onPressed: isLoading ? null : _login,
                  
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Forgot Password ?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFF8C69),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 100),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFF7C91B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 100,
                                      vertical: 15,
                                    ),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF2B2D42),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Don\'t have an account? ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Register',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFFF8C69),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              //
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: const Color(AppColors.divider),
                                      thickness: 0.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text('Or Login With'),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: Color(AppColors.divider),
                                      thickness: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFE5E5E5),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                      'assets/images/devicon_google.png',
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFE5E5E5),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset('assets/images/apple.png'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Center(
                                child: Image.asset(
                                  'assets/images/home_Indicator.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
