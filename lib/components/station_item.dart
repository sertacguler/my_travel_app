import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // intl paketi için import

class StationItem extends StatelessWidget {
  final String imagePath;  // Arka plan resmi
  final String country;    // Ülke adı
  final String date;       // Tarih
  final VoidCallback onRemove;  // Çıkarma işlemi için callback

  const StationItem({
    Key? key,
    required this.imagePath,
    required this.country,
    required this.date,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.parse(date));  // Tarihi formatla

    return Container(
      height: 150,  // Yüksekliği artırıldı
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 3),  // Kenarlardan az boşluk
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1), // İnce beyaz çerçeve eklendi
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5), BlendMode.darken),  // Hafif karartma
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
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),  // İç padding
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
                  ),
                ),
                Text(
                  country,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: CustomDeleteButton(onRemove: onRemove),
          ),
        ],
      ),
    );
  }
}

class CustomDeleteButton extends StatelessWidget {
  final VoidCallback onRemove;

  const CustomDeleteButton({Key? key, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRemove,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
