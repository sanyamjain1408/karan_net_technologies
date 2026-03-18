import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Widget buildNavItem(String iconPath, int index) {
    bool isSelected = currentIndex == index;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent, // 🔥 circle
        shape: BoxShape.circle,
      ),
      child: ImageIcon(
        AssetImage(iconPath),
        size: 24,
        color: isSelected ? Colors.white : Colors.black54, // 🔥 icon color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      
      child: Container(
        decoration: const BoxDecoration(
          
          color: Color(0xffEAEAF5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,

          showSelectedLabels: false,
          showUnselectedLabels: false,

          selectedFontSize: 0, // 🔥 gap remove
          unselectedFontSize: 0,

          // ❌ remove default color
          selectedItemColor: Colors.transparent,
          unselectedItemColor: Colors.transparent,

          items: [
            BottomNavigationBarItem(
              icon: buildNavItem('assets/home.png', 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildNavItem('assets/categories.png', 1),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildNavItem('assets/history.png', 2),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildNavItem('assets/profile.png', 3),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
