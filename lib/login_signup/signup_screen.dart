import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karan_net_technologies/config/app_config.dart';
import 'package:karan_net_technologies/login_signup/login_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePass = true;
  bool obscureConfirm = true;
  bool isLoading = false;

  

  /// 📅 DATE PICKER
  Future pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dobController.text = DateFormat("dd/MM/yyyy").format(pickedDate);
    }
  }

  /// 🚀 REGISTER API
  Future<void> registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String mobile = mobileController.text.trim();
    String dob = dobController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    /// ✅ PASSWORD MATCH CHECK
    if (password != confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password not match")),
      );
      return;
    }

    setState(() => isLoading = true);

    final url = "${ApiConfig.baseUrl}/user_app/register/";

    final body = {
      "full_name": name,
      "email": email,
      "mobile_number": mobile,
      "date_of_birth": dob,
      "password": password, 
      "confirm_password" : confirmPassword,
    };

     print("------------------------- POST REQUEST ---------------------------------");
    print("URL: $url");
    print("BODY: ${jsonEncode(body)}");

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      var data = jsonDecode(response.body);

       print("----------------------------- POST RESPONSE -----------------------------");
      print("Response Body: ${response.body}");

     

      setState(() => isLoading = false);

      if (data["status"] == true) {
        showOtpDialog(email); // 🔥 OTP POPUP
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Error")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server Error")),
      );
    }
  }

  /// 🔢 OTP DIALOG
  void showOtpDialog(String email) {
    TextEditingController otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter OTP"),
          content: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: const InputDecoration(
              hintText: "Enter 4 digit OTP",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await verifyOtp(email, otpController.text.trim());
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  /// ✅ VERIFY OTP
  Future<void> verifyOtp(String email, String otp) async {
    final url = "${ApiConfig.baseUrl}/user_app/verify-otp/";

    final body = {
      "email": email,
      "otp": otp,
    };

    print("------------------------- POST REQUEST ---------------------------------");
    print("URL: $url");
    print("BODY: ${jsonEncode(body)}");

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      var data = jsonDecode(response.body);

      print("----------------------------- POST RESPONSE -----------------------------");
      print("Response Body: ${response.body}");

      if (data["status"] == true) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup Successful")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Invalid OTP")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Verify Failed")),
      );
    }
  }

  /// 🎨 INPUT DECORATION
  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xffdcdcf2),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff195a9b),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              "Create Account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            /// FORM CONTAINER
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

                    const Text("   Full Name",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: nameController,
                      decoration: inputDecoration("Enter your name"),
                      validator: (v) =>
                          v!.isEmpty ? "Fill the data" : null,
                    ),

                    const SizedBox(height: 15),

                    const Text("   Email",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: emailController,
                      decoration:
                          inputDecoration("example@gmail.com"),
                      validator: (v) {
                        if (v!.isEmpty) return "Fill the data";
                        if (!v.contains("@")) return "Enter valid email";
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    const Text("   Mobile Number",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration("1234567890"),
                      validator: (v) {
                        if (v!.isEmpty) return "Fill the data";
                        if (v.length != 10)
                          return "Enter 10 digit mobile";
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    const Text("   Date Of Birth",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: dobController,
                      readOnly: true,
                      onTap: pickDate,
                      decoration: inputDecoration("DD/MM/YYYY"),
                      validator: (v) =>
                          v!.isEmpty ? "Fill the data" : null,
                    ),

                    const SizedBox(height: 15),

                    const Text("   Password",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePass,
                      decoration: inputDecoration("••••••••").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(obscurePass
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscurePass = !obscurePass;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text("   Confirm Password",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfirm,
                      decoration: inputDecoration("••••••••").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(obscureConfirm
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscureConfirm = !obscureConfirm;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            registerUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff195a9b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20)),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Already have an account? Log In",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    )
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