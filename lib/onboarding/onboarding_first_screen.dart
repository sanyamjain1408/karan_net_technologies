import 'package:flutter/material.dart';
import 'package:karan_net_technologies/onboarding/onboarding_second_screen.dart';

class OnboardingFirstScreen extends StatefulWidget {
  const OnboardingFirstScreen({super.key});

  @override
  State<OnboardingFirstScreen> createState() => _OnboardingFirstScreenState();
}

class _OnboardingFirstScreenState extends State<OnboardingFirstScreen> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Column(
        children: [

          const SizedBox(height: 100),

          const Center(
            child: Text(
              "Welcome To\nService Manager",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 40),

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
                      "assets/onboardingfirst.png",
                      height: 200,
                    ),

                    /// This pushes next button to bottom
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
                                const OnboardingSecondScreen(),
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

                    const SizedBox(height: 30),

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