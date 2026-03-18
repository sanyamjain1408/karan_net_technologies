import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karan_net_technologies/config/app_config.dart';
import 'package:karan_net_technologies/screens/firest_comman_screen.dart';
import 'package:karan_net_technologies/screens/home_screen.dart';
import 'package:karan_net_technologies/login_signup/signup_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;4

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  ///  LOGIN API
  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() => isLoading = true);

    final url = "${ApiConfig.baseUrl}/user_app/login/";

    final body = {
      "email": email,
      "password": password,
    };

    print(
        "------------------------- POST REQUEST ---------------------------------");
    print("URL: $url");
    print("BODY: ${jsonEncode(body)}");

    try {
      var response = await http
          .post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      var data = jsonDecode(response.body);

      print(
          "----------------------------- POST RESPONSE -----------------------------");
      print("RESPONSE: ${response.body}");

      setState(() => isLoading = false);

      /// ✅ SUCCESS
      if (data["status"] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FirestCommanScreen()),
        );
      }

      ///  FAIL
      else {
        String message = data["message"] ?? "";

        ///  Invalid password
        if (message.toLowerCase().contains("password")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password is not correct")),
          );
        }

        ///  Email not registered
        else if (message.toLowerCase().contains("not register")) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SignupScreen()),
          );
        }

        ///  Other error
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      }
    } catch (e) {
      setState(() => isLoading = false);

      print("ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server Error")),
      );
    }
  }

  /// 🔵 GOOGLE LOGIN
  Future googleLogin() async {
    try {
      final user = await _googleSignIn.signIn();

      if (user != null) {
        print(user.email);
        print(user.displayName);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Login Success")),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xffdcdcf2),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff195a9b),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// EMAIL
                    const Text("Username Or Email"),
                    const SizedBox(height: 6),

                    TextFormField(
                      controller: emailController,
                      decoration: inputDecoration("example@example.com"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    /// PASSWORD
                    const Text("Password"),
                    const SizedBox(height: 6),

                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: inputDecoration("••••••••").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40),

                    /// LOGIN BUTTON
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff195a9b),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// GOOGLE LOGIN
                    Center(
                      child: InkWell(
                        onTap: googleLogin,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              "G",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// SIGNUP REDIRECT
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
