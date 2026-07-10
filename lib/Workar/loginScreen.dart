import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isLoggedIn", true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );

    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter Email and Password"),
        ),
      );
      return;
    }

    if (emailController.text.trim() == savedEmail &&
        passwordController.text.trim() == savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login Successful"),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Email or Password"),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding:EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration("Enter Email"),
            ),

            SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: inputDecoration("Enter Password"),
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loginUser,
                child: Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}