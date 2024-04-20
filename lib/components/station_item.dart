import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // intl paketi için import

class StationItem extends StatelessWidget {
  final String imagePath; // Arka plan resmi
  final String country; // Ülke adı
  final String date; // Tarih
  final VoidCallback onRemove; // Çıkarma işlemi için callback

  const StationItem({
    Key? key,
    required this.imagePath,
    required this.country,
    required this.date,
    required this.onRemove,
  }) : super(key: key); // Anahtar üst sınıfa geçirildi

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy')
        .format(DateTime.parse(date)); // Tarihi formatla

    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontFamily: 'Oswald'
                  ),
                ),
                Text(
                  country,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -2,
                    fontFamily: 'Oswald'
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
