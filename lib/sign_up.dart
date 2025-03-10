import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/database_handler.dart';
import 'auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final DatabaseHandler _dbHandler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/photos/pomodoro_logo.png', height: 100),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        iconColor: Theme.of(context).primaryColorLight,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.black38),
                        icon: Icon(Icons.email),
                        filled: true,
                        fillColor: Theme.of(context).primaryColorDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an email' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        iconColor: Theme.of(context).primaryColorLight,
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.black38),
                        icon: Icon(Icons.lock),
                        filled: true,
                        fillColor: Theme.of(context).primaryColorDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) => value!.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).primaryColorLight,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            String? appCheckToken =
                                await FirebaseAppCheck.instance.getToken();
                            print('App Check Token: $appCheckToken');

                            String? uid = await _dbHandler.signUp(
                              _emailController.text.trim(),
                              _passwordController.text,
                            );

                            if (_auth.currentUser != null && uid != null) {
                              Navigator.pushReplacementNamed(
                                  context, '/signin');
                            }
                          } on FirebaseAuthException catch (e) {
                            String errorMessage = 'An error occurred';
                            switch (e.code) {
                              case 'email-already-in-use':
                                errorMessage =
                                    'This email is already registered';
                                break;
                              case 'invalid-email':
                                errorMessage = 'Invalid email format';
                                break;
                              case 'weak-password':
                                errorMessage = 'Password is too weak';
                                break;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}')),
                            );
                          }
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColorLight),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                      child: Text('Already have an account? Sign In'),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey),
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        size: 24,
                        color: Colors.red,
                      ),
                      label: const Text('Sign up with Google'),
                      onPressed: () async {
                        try{
                          await _auth.signInWithGoogle();
                          Navigator.pushReplacementNamed(context, '/home');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Failed to sign in with Google')),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey),
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                        size: 24,
                        color: Colors.black,
                      ),
                      label: const Text('Sign in with Apple'),
                      onPressed: () async {
                        try {
                          await _auth.signInWithApple();
                          Navigator.pushReplacementNamed(context, '/home');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Failed to sign in with Apple')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
