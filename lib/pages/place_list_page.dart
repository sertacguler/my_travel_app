import 'package:flutter/material.dart';
import '../components/station_item.dart';
import '../components/theme.dart';
import '../components/add_place_modal.dart';
import '../info/placeData.dart';
import '../services/PlaceService.dart';

class PlaceListPage extends StatefulWidget {
  @override
  _PlaceListPageState createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  final List<PlaceData> places = [
    PlaceData(
        id: "1",
        imageUrl: "https://source.unsplash.com/random/300x300?v=3",
        title: "Eiffel Tower",
        details: "Amazing view!",
        country: "Italy",
        date: DateTime.now()
            .subtract(Duration(days: 10))
            .toString() // Örnek tarih
        ),
    PlaceData(
        id: "2",
        imageUrl: "https://source.unsplash.com/random/300x300?v=4",
        title: "Colosseum",
        details: "Iconic ancient Roman gladiatorial arena.",
        country: "France",
        date: DateTime.now()
            .subtract(Duration(days: 49))
            .toString() // Örnek tarih
        ),
    PlaceData(
        id: "3",
        imageUrl: "https://source.unsplash.com/random/300x300?v=5",
        title: "Malaga",
        details:
            "Spain is a parliamentary democracy and a constitutional monarchy",
        country: "Spain",
        date: DateTime.now()
            .subtract(Duration(days: 100))
            .toString() // Örnek tarih
        ),
    // Diğer yerler eklenebilir
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore The World",
            style: TextStyle(
                letterSpacing: 2,
                color: AppColors.navyBlue,
                fontStyle: FontStyle.italic,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'NothingYouCouldDo')),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "YOUR QUESTS",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald'),
                ),
                Text(
                  "Upcoming",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -2,
                      fontFamily: 'Oswald'),
                ),
                SizedBox(height: 25), // Buton ile yazı arasına mesafe
                Container(
                  width: double.infinity,
                  color: Colors.grey[100],
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FloatingActionButton(
                          child: Icon(Icons.add, size: 30, color: Colors.white),
                          onPressed: _showAddPlaceModal,
                          backgroundColor: Colors.orange,
                          elevation: 0, // Gölge kaldırıldı
                        ),
                      ),
                      Positioned(
                        right: -30,
                        bottom: -85,
                        top: -100, // Resmin üst kısmını kutudan dışarı çıkart
                        child: Image.asset(
                            'assets/dagLogo.png', // Yerel asset kullanımı
                            //'assets/daga.png',
                            //'assets/dage.png',
                            width: 140),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16), // Buton ile yazı arasına mesafe
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                var place = places[index];
                return Transform.translate(
                  offset: Offset(
                      0,
                      -60 *
                          index
                              .toDouble()), // Her bir item üstteki item ile bindiriliyor
                  child: InkWell(
                    onTap: () {
                      String? placeId = place.id;
                      Navigator.pushNamed(context, '/stationList',
                          arguments: placeId);
                    },
                    child: StationItem(
                      key: ValueKey(place.id), // Benzersiz key kullanımı
                      imagePath: place.imageUrl!,
                      country: place.country!,
                      date: place.date!,
                      onRemove: () => removePlace(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void removePlace(int index) {
    setState(() {
      places.removeAt(index);
    });
  }

  void _addNewPlace(String title, String details, String country, String date) {
    PlaceService.addPlaceToServer(title, details, country, date)
        .catchError((error) {
      print('Error adding place to server: $error');
    });
    setState(() {
      places.add(PlaceData(
          id: DateTime.now().toString(),
          imageUrl:
              "https://source.unsplash.com/random/300x300?v=${places.length + 3}",
          title: title,
          details: details,
          country: country,
          date: date));
    });
  }

  void _showAddPlaceModal() {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddPlaceModal(addPlaceCallback: _addNewPlace),
    );
  }
}
