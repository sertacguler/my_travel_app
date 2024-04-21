import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService {
  // Veriyi server'a ekleyen metod
  static Future<void> addPlaceToServer(
      String title, String details, String country, String date) async {
    try {
      var response = await http.post(
        Uri.parse('http://localhost:8500/api/place/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'details': details,
          'country': country,
          'date': date,
        }),
      );

      if (response.statusCode == 200) {
        // Sunucudan başarılı bir yanıt alındı, işleme devam edin
        print('Place added to server successfully');
      } else {
        // Sunucudan hata yanıtı alındı
        print('Failed to add place to server: ${response.body}');
      }
    } catch (e) {
      print('Exception when calling addPlaceToServer: $e');
      throw Exception('Failed to add place due to an exception');
    }
  }
}
