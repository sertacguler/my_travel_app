import 'package:flutter/material.dart';
import '../components/theme.dart';

class CategorySelector extends StatefulWidget {
  final int selectedIndex;
  final List<String> categories;
  final Function(int) onCategorySelected;

  CategorySelector({required this.selectedIndex, required this.categories, required this.onCategorySelected});

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.categories.asMap().entries.map((entry) {
          int idx = entry.key;
          String category = entry.value;
          return GestureDetector(
            onTap: () {
              widget.onCategorySelected(idx);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: widget.selectedIndex == idx ? Colors.orange : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: widget.selectedIndex == idx ? Colors.white : AppColors.navyBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16, fontFamily: 'Oswald'
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
