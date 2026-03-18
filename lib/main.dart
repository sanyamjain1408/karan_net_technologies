import 'package:flutter/material.dart';
import 'package:karan_net_technologies/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'karan_net_technologies',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      
       );
  }
}
