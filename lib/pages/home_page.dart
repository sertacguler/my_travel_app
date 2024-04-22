import 'package:flutter/material.dart';
import '../components/theme.dart';
import '../components/CategoryCarousel.dart';
import '../components/CategorySelector.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String username = "User"; // Gerçek uygulamada bu değer dinamik olarak değişebilir.
  final String gender = "female"; // Kullanıcı cinsiyeti: "male" veya "female"
  int _selectedCategoryIndex = 0; // Managing selected category index
  final List<String> categories = ["Recommended", "Popular", "Most Visited", "Europa", "Asia", "Amerika"]; // List of categories

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi $username',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600], fontFamily: 'Oswald',
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: gender == "male" ? AppColors.avatarBlue : AppColors.avatarPink,
                    child: Icon(
                      gender == "male" ? Icons.person_outline : Icons.person_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                    radius: 20,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Where are you traveling next?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  fontFamily: 'Oswald',
                  color: AppColors.navyBlue,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search destinations",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              CategorySelector(
                selectedIndex: _selectedCategoryIndex,
                categories: categories,
                onCategorySelected: _onCategorySelected,
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: CategoryCarousel(
                  categoryIndex: _selectedCategoryIndex,
                  categories: categories,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
