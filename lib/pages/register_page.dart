import 'package:auth_project/components/my_button.dart';
import 'package:auth_project/components/my_textfield.dart';
import 'package:auth_project/components/square_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showErrorMessage('Please enter both email and password');
      return;
    }

    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try create the user
    try {
      //check if password and confirm password are the same
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        //Show error message
        showErrorMessage('Passwords do not match');
      }
      // Pop the indicator
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // Pop the circular progress indicator
      if (mounted) {
        Navigator.pop(context);
      }

      // Wrong email or password
      showErrorMessage(e.code);
    }
  }

  //Wrong email message popuopp

  void showErrorMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(errorMessage),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                const Icon(Icons.lock, size: 50),
                const SizedBox(height: 25),
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Comfirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTitle(
                      widget: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const SquareTitle(
                      widget: Icon(
                        Icons.apple,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
