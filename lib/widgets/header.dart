import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karan_net_technologies/screens/search_screen.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  Size get PreferredSize => const Size.fromHeight(120);

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff1E5AA8),
      elevation: 0,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 120,
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
          child: Column(
            children: [
             const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Notification
                   CircleAvatar(
                    
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.notifications, size: 18),
                  )
                ],
              ),

              const SizedBox(height: 10),


              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: searchController,
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                  milliseconds: 500), // 🔥 speed control
                              pageBuilder: (_, __, ___) => const SearchScreen(),

                              transitionsBuilder: (_, animation, __, child) {
                                final offsetAnimation = Tween<Offset>(
                                  begin:
                                      const Offset(0, 1), // 🔥 niche se aayega
                                  end: Offset.zero,
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ));

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search, color: Colors.grey),
                          hintText: "Search Services...",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          print("Search: $value");
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
