import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E5AA8),

      body: Column(
        children: [

          /// 🔵 TOP HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Row(
              children: [

                /// 👤 PROFILE IMAGE
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35, color: Colors.blue),
                ),

                const SizedBox(width: 15),

                /// 🧑 NAME + EMAIL
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Richie Rich",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "rich@gmail.com",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                /// ✏️ EDIT ICON
                const Icon(Icons.edit, color: Colors.white),
              ],
            ),
          ),

          /// ⚪ WHITE CONTAINER
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),

              child: ListView(
                children: [

                  /// 🔹 SECTION 1
                  buildCard([
                    buildItem(Icons.person_outline, "Personal Info"),
                    buildItem(Icons.location_on_outlined, "Addresses"),
                  ]),

                  const SizedBox(height: 20),

                  /// 🔹 SECTION 2
                  buildCard([
                    buildItem(Icons.notifications_none, "Notifications"),
                    buildItem(Icons.payment, "Payment Method"),
                    buildItem(Icons.help_outline, "FAQs"),
                    buildItem(Icons.reviews_outlined, "User Reviews"),
                  ]),

                  const SizedBox(height: 20),

                  /// 🔴 LOGOUT
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 10),
                        Text("Log Out"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 CARD WRAPPER
  Widget buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: children),
    );
  }

  /// 🔥 SINGLE ITEM
  Widget buildItem(IconData icon, String title) {
    return InkWell(
      onTap: () {
        print(title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(title)),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }
}