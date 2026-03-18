import 'package:flutter/material.dart';
import 'package:karan_net_technologies/login_signup/signup_screen.dart';

class OnboardingSecondScreen extends StatefulWidget {
  const OnboardingSecondScreen({super.key});

  @override
  State<OnboardingSecondScreen> createState() => _OnboardingSecondScreenState();
}

class _OnboardingSecondScreenState extends State<OnboardingSecondScreen> {

  int currentIndex = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Column(
        children: [

          const SizedBox(height: 100),

          /// Welcome Text
          const Center(
            child: Text(
              "Are You Ready To\nTake Control of\nYour Services...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 40),

          /// White Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                
                    const SizedBox(height: 80),
                
                    /// Image
                    Image.asset(
                      "assets/onboardingsecond.png",
                      height: 200,
                    ),
                
                    const Spacer(),
                
                    /// Next Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                const SignupScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 10),
                
                    /// Dots Indicator
                    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: currentIndex == index ? 10 : 8,
                    height: currentIndex == index ? 10 : 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.blue
                          : Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                  );
                }),
                            ),
                
                const SizedBox(height: 30,)
                            
                
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}