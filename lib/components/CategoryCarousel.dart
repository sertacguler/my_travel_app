import 'package:flutter/material.dart';

class CategoryCarousel extends StatefulWidget {
  final int categoryIndex;
  final List<String> categories;

  CategoryCarousel({required this.categoryIndex, required this.categories});

  @override
  _CategoryCarouselState createState() => _CategoryCarouselState();
}
class _CategoryCarouselState extends State<CategoryCarousel> {
  List<String> getFilteredData() {
    Map<String, List<String>> data = {
      "Recommended": ["Image1", "Image2", "Image3", "Image4", "Image5"],
      "Popular": ["Image6", "Image7", "Image8", "Image9", "Image10"],
      // Diğer kategorilere ait veriler...
    };
    return data[widget.categories[widget.categoryIndex]] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = getFilteredData();

    return Container(
      height: 200, // Container'ın yüksekliği
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 200, // Genişlik sabit
            height: 200, // Yükseklik sabit
            child: Card(
              color: Colors.blue,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    items[index],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
