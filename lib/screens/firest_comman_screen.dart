import 'package:flutter/material.dart';
import 'package:karan_net_technologies/screens/categories_screen.dart';
import 'package:karan_net_technologies/screens/history_screen.dart';
import 'package:karan_net_technologies/screens/home_screen.dart';
import 'package:karan_net_technologies/screens/profile_screen.dart';
import '../widgets/header.dart';
import '../widgets/bottom_nav.dart';

class FirestCommanScreen extends StatefulWidget {
  const FirestCommanScreen({super.key});

  @override
  State<FirestCommanScreen> createState() => _FirestCommanScreenState();
}

class _FirestCommanScreenState extends State<FirestCommanScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  /// Center screens
  final List<Widget> pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,

      /// HEADER (FIXED)
     appBar: currentIndex == 3
    ? null
    : const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppHeader(),
      ),

      /// CENTER CHANGE
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: const Color(0xff1E5AA8),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(16),
          
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30), //  yahi main cheez hai
              ),
            ),
            child: IndexedStack(
              index: currentIndex,
              children: pages,
            ),
          ),
        ),
      ),

      /// FOOTER (FIXED)
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      
    );
  }
}