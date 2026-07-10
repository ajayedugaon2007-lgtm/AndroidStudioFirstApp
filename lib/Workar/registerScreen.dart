import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();


    await prefs.setString("name", name);
    await prefs.setString("email", email);
    await prefs.setString("password", password);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Registration Successful")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Padding(
        padding:EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),

              TextField(
                controller: nameController,
                decoration: inputDecoration("Enter Name"),
              ),

              SizedBox(height: 15),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration("Enter Email"),
              ),

              SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: inputDecoration("Enter Password"),
              ),

              SizedBox(height: 15),

              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: inputDecoration("Confirm Password"),
              ),

              SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: registerUser,
                  child: Text(
                    "REGISTER",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}