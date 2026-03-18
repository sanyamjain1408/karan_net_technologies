import 'package:flutter/material.dart';
import 'package:karan_net_technologies/screens/firest_comman_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  void submitOtp(){

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FirestCommanScreen(),
      ),
    );

    // if(_formKey.currentState!.validate()){

    //   print("OTP : ${otpController.text}");

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("OTP Submitted")),
    //   );
    // }
  }

  InputDecoration inputDecoration(String hint){
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xffdcdcf2),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
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
              "OTP Authentication",
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

                    const Text("Enter OTP"),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: otpController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration("••••••"),
                      validator: (value){

                        if(value!.isEmpty){
                          return "Enter OTP";
                        }

                        if(value.length < 6){
                          return "OTP must be 6 digits";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 40),

                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 45,
                        child: ElevatedButton(

                          onPressed: submitOtp,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff195a9b),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 16, color: Colors.white, ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 200),

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