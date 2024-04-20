import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../components/custom_button.dart'; // Eğer path yanlış ise güncelleyin
import '../components/theme.dart';
import '../components/customAppBar.dart';
import '../components/searchLocation.dart';
import '../components/location_dialog.dart';
import '../components/bottom_detail_widget.dart';
import '../info/stationData.dart';
import '../info/locationData.dart';
import './station_list_page.dart';
import './home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/DottedLinePainter.dart';
import 'package:intl/intl.dart'; // intl paketi için import

class MapPage extends StatefulWidget {
  final String placeId;
  double? initialLat;
  double? initialLng;
  MapPage({Key? key, required this.placeId, this.initialLat, this.initialLng})
      : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> markers = [];
  //List<StationData> markersInfo = [];
  late MapController mapController;
  double currentZoom = 15.0; // Örnek bir başlangıç zoom seviyesi

  final List<StationData> markersInfo = [
    StationData(
        id: "1",
        imageUrl: "https://source.unsplash.com/random/300x300?v=1",
        title: "Durak 1",
        details: "Açıklama 1",
        type: "default",
        country: "Italy",
        status: 3,
        date: DateTime.now()
            .subtract(Duration(days: 100))
            .toString(), // Örnek tarih
        lat: 39.993936,
        lng: 32.887406),
    StationData(
        id: "2",
        imageUrl: "https://source.unsplash.com/random/300x300?v=2",
        title: "Durak 2",
        details: "Açıklama 2",
        type: "default",
        country: "Italy",
        status: 1,
        date: DateTime.now()
            .subtract(Duration(days: 100))
            .toString(), // Örnek tarih
        lat: 30.042328,
        lng: 31.2324968),
    StationData(
        id: "3",
        imageUrl: "https://source.unsplash.com/random/300x300?v=3",
        title: "Durak 3",
        details: "Açıklama 3",
        type: "Hotel",
        country: "Italy",
        status: 2,
        date: DateTime.now()
            .subtract(Duration(days: 100))
            .toString(), // Örnek tarih
        lat: 30.042328,
        lng: 31.2324968)
  ];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _addMarker(StationData stationData, String markerType) {
    Icon icon;
    switch (markerType) {
      case 'Restaurant':
        icon = Icon(Icons.location_on, color: Colors.red);
        break;
      case 'Park':
        icon = Icon(Icons.location_on, color: Colors.green);
        break;
      case 'Hotel':
        icon = Icon(Icons.location_on, color: Colors.blue);
        break;
      default:
        icon = Icon(Icons.location_on, color: AppColors.navyBlue);
    }

    final marker = Marker(
      point: LatLng(stationData.lat, stationData.lng),
      child: GestureDetector(
        onTap: () {/*_showBottomDialog(context, stationData);*/},
        child: Center(child: icon),
      ),
    );

    setState(() {
      markers.add(marker);
      markersInfo.add(stationData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Travelquest'),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                center: LatLng(widget.initialLat ?? 30.042328,
                    widget.initialLng ?? 31.2324968),
                zoom: widget.initialLat != null ? 18.0 : currentZoom,
                onTap: (_, position) => _showLocationDialog(position)),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
          Positioned(
            left: 20,
            bottom: 100,
            child: FloatingActionButton(
              onPressed: () {
                _showSearchInput(context);
              },
              child: Icon(Icons.search, color: AppColors.white),
              backgroundColor: AppColors.navyBlue,
            ),
          ),
          Positioned.fill(
            child: DraggableScrollableSheet(
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: markersInfo.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              var data = markersInfo[0];
                              return _buildHeader(data);
                            } else {
                              var data = markersInfo[index - 1];
                              final formattedDate = DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(data.date));
                              return _buildListItem(data, formattedDate);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              initialChildSize: 0.5,
              minChildSize: 0.20,
              maxChildSize: 0.70,
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationDialog(LatLng position) async {
    LocationData? result = await showDialog<LocationData>(
      context: context,
      builder: (BuildContext context) {
        return LocationDialog(position: position); // Örnek bir koordinat
      },
    );

    if (result != null) {
      print(
          "Yer adı: ${result.name}, Yorum: ${result.comment}, Marker Tipi: ${result.markerType}");
      _addMarker(
          StationData(
              id: DateTime.now().toString(),
              title: result.name,
              country: "Italy",
              status: 2,
              date: DateTime.now().toString(),
              details: result.comment,
              imageUrl: "",
              lng: position.longitude,
              lat: position.latitude,
              type: result.markerType),
          result.markerType);
    }
  }

  void _showSearchInput(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        TextEditingController searchController = TextEditingController();
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: "Search",
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  StationData? stationData =
                      await searchLocation(searchController.text);
                  if (stationData != null) {
                    _addMarker(stationData, 'default');
                    print(stationData);
                    mapController.move(LatLng(stationData.lat, stationData.lng),
                        mapController.zoom);
                  }
                  Navigator.pop(
                      context); // Optionally close the sheet after search
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomDialog(BuildContext context, StationData stationData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return BottomDetailWidget(
          stationData: stationData,
          onClose: () => Navigator.pop(ctx),
        );
      },
    );
  }

  void _navigateToStationListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StationListPage(placeId: widget.placeId)),
    );
  }

  /*void _saveMarkers() {
    // Burada yerel bir veritabanı veya global durum yönetimi ile kaydetme işlemini yapabilirsiniz.
    // Diyelim ki bu markerlar başka bir sayfada bir liste olarak gösterilecek.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StopsPage(markers: markers)),
    );
  }*/
}

Widget _buildHeader(StationData data) {
  return Column(
    children: [
      SizedBox(height: 8),
      Container(
        height: 4,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(height: 8),
      Text(
        data.country + ' Quest',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
            fontFamily: 'Oswald'
        ),
      ),
      SizedBox(height: 8),
    ],
  );
}

Widget _buildListItem(StationData data, String formattedDate) {
  Color dynamicColor = AppColors.white;
  Icon listIcon;
  Icon arrowIcon;
  Text countryText = Text(data.country,
      style: TextStyle(
          color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
  Text dateText = Text(formattedDate,
      style: TextStyle(
          color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
  Text dataTitle = Text(data.title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
  switch (data.status) {
    case 1:
      listIcon = Icon(Icons.location_on, color: AppColors.green, size: 30.0);
      dateText = Text("RIGTH NOW",
          style: TextStyle(
              color: AppColors.green,
              fontSize: 13,
              letterSpacing: -0.5,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      countryText = Text(data.country,
          style: TextStyle(
              color: AppColors.green,
              fontSize: 14,
              letterSpacing: -0.5,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      arrowIcon = Icon(Icons.arrow_forward, size: 20, color: AppColors.green);
      dataTitle = Text(data.title,
          style: TextStyle(
              color: AppColors.navyBlue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      dynamicColor = AppColors.white;
      break;
    case 2:
      listIcon = Icon(Icons.location_on, color: AppColors.navyBlue, size: 30.0);
      dateText = Text("WAITING",
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      countryText = Text(data.country,
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              letterSpacing: -0.5,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      arrowIcon =
          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.navyBlue);
      dataTitle = Text(data.title,
          style: TextStyle(
              color: AppColors.navyBlue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      dynamicColor = AppColors.lightLightGrey;
      break;
    case 3:
      listIcon = Icon(Icons.check_circle, color: AppColors.green, size: 30.0);
      dateText = dateText;
      countryText = Text(data.country,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              letterSpacing: -0.5,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      arrowIcon = Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey);
      dataTitle = Text(data.title,
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      dynamicColor = AppColors.lightLightGrey;
      break;
    default:
      listIcon = Icon(Icons.location_on,
          color: Colors.grey, size: 30.0); // Default case
      dateText =
          Text("", style: TextStyle(color: Colors.grey[600], fontSize: 12));
      countryText = Text(data.country,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              letterSpacing: -0.5,
              fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      arrowIcon = Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey);
      dataTitle = Text(data.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'));
      dynamicColor = AppColors.lightLightGrey;
  }

  return Container(
    margin: EdgeInsets.fromLTRB(7, 1, 7, 0),
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    decoration: BoxDecoration(
      color: dynamicColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: AppColors.lightGrey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Container(
          width: 2,
          height: 50,
          margin: EdgeInsets.only(left: 12),
          child: CustomPaint(
            painter: DottedLinePainter(color: Colors.grey),
          ),
        ),
        Positioned(
          left: -3,
          child: listIcon,
        ),
        Padding(
          padding: EdgeInsets.only(left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  countryText,
                  dateText,
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [dataTitle, arrowIcon],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
