import 'package:flutter/material.dart';

///  MODEL
class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});
}

/// SCREEN
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  ///  LIST (ABHI STATIC - BAAD ME API SE AAYEGA)
  List<CategoryModel> categories = [
    CategoryModel(name: "PAN Card", image: "assets/pan.png"),
    CategoryModel(name: "Voter Card", image: "assets/voter.png"),
    CategoryModel(name: "Gun License", image: "assets/gun.png"),
    CategoryModel(name: "Passport", image: "assets/passport.png"),
    CategoryModel(name: "Tax Return", image: "assets/tax.png"),
    CategoryModel(name: "RTO", image: "assets/rto.png"),
    CategoryModel(name: "Electricity Bill", image: "assets/electricity.png"),
    CategoryModel(name: "Kundli", image: "assets/kundli.png"),
    CategoryModel(name: "FSSAI", image: "assets/fssai.png"),
    CategoryModel(name: "Non-Creamy Certificate", image: "assets/non_creamy.png"),
    CategoryModel(name: "E-FIR", image: "assets/fir.png"),
    CategoryModel(name: "Marriage Certificate", image: "assets/marriage.png"),
    CategoryModel(name: "7-12 Certificate", image: "assets/certificate.png"),
    CategoryModel(name: "DTP Tally", image: "assets/tally.png"),
    CategoryModel(name: "MS Office CCC", image: "assets/office.png"),
  ];

  @override
  Widget build(BuildContext context) {

    ///  SORT (ALPHABETICAL)
    categories.sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///  TITLE
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "All Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ///  GRID
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                itemCount: categories.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //  3 column
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),

                itemBuilder: (context, index) {
                  final item = categories[index];

                  return GestureDetector(
                    onTap: () {
                      print(item.name);
                    },

                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                          ),
                        ],
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          /// IMAGE
                          Image.asset(
                            item.image,
                            height: 40,
                          ),

                          const SizedBox(height: 10),

                          ///  TEXT
                          Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}