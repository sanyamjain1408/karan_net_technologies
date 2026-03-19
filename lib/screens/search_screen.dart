import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController controller = TextEditingController();

  List<String> allItems = [
    "Gun License",
    "Tax Return",
    "Food Safety",
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void filterSearch(String value) {
    setState(() {
      filteredItems = allItems
          .where((item) =>
              item.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E5AA8),

      body: SafeArea(
        child: Column(
          children: [

            /// BACK + SEARCH
            Container(
              padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
              margin: EdgeInsets.fromLTRB(0, 12, 12, 12),
              alignment: Alignment.center,
              child: Row(
                children: [

                  /// Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  /// Search Field
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: controller,
                        autofocus: true, //  open hote hi keyboard
                        onChanged: filterSearch,
                        decoration: const InputDecoration(
                          hintText: "Search Services...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///  RESULT BOX
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.north_east),
                      title: Text(filteredItems[index]),
                      trailing: const Icon(Icons.history),
                      onTap: () {
                        print(filteredItems[index]);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}