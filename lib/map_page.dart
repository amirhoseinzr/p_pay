import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  double _zoomLevel = 13.0; // Initial zoom level
  LatLng _mapCenter = LatLng(51.51, -0.13); // Initial center of the map
  LatLng? _selectedLocation; // To store the selected location for adding a shop
  LatLng? _userLocation;
  Timer? _longPressTimer;

  // Define the Four Seasons Hotel location
  final List<Map<String, dynamic>> hotels = [ {
    'name': 'Four Seasons Hotel',
    'location': 'San Francisco at Embarcadero',
    'specialization': 'Hotel',
    'latlong': LatLng(37.7952, -122.3977), // Latitude and longitude for the hotel
  },
    {
      'name': 'Hotel Vitale',
      'location': 'Embarcadero, San Francisco',
      'specialization': 'Hotel',
      'latlong': LatLng(37.7749, -122.4194),
    },
    {
      'name': 'Bayfront Lodge',
      'location': 'Embarcadero, San Francisco',
      'specialization': 'Hotel',
      'latlong': LatLng(37.7633, -122.4348),
    },
    {
      'name': 'Marina Bay Inn',
      'location': 'Ferry Building, San Francisco',
      'specialization': 'Hotel',
      'latlong': LatLng(37.7858, -122.4010),
    },
    {
      'name': 'Golden Gate Suites',
      'location': 'Financial District, San Francisco',
      'specialization': 'Hotel',
      'latlong': LatLng(37.7694, -122.4862),
    },
    {
      'name': 'Pier View Hotel',
      'location': 'Embarcadero, San Francisco',
      'specialization': 'Hotel',
      'latlong': LatLng(37.78, -122.4345),
    },
    {
      'name': 'Harbor Point Lodge',
      'location': 'Embarcadero, San Francisco',
      'specialization': 'Hotel',
      'latlong': LatLng(37.7933, -122.3450),
    },
    {
      'name': 'Waterfront Inn',
      'location': 'Financial District, San Francisco',
      'specialization': 'Hotel',
      'latlong': LatLng(37.7945, -122.468),
    },
    {
      'name': 'The Savoy',
      'location': 'Strand, London',
      'specialization': 'Luxury Hotel',
      'latlong': LatLng(51.5104, -0.1204),
    },
    {
      'name': 'The Ritz London',
      'location': 'Piccadilly, London',
      'specialization': 'Luxury Hotel',
      'latlong': LatLng(51.5070, -0.1416),
    },
    {
      'name': 'Shangri-La The Shard',
      'location': 'The Shard, London Bridge',
      'specialization': 'Hotel',
      'latlong': LatLng(51.5045, -0.0865),
    },
    {
      'name': 'Claridge\'s',
      'location': 'Brook Street, Mayfair',
      'specialization': 'Luxury Hotel',
      'latlong': LatLng(51.5124, -0.1481),
    },
    {
      'name': 'The Langham',
      'location': 'Regent Street, London',
      'specialization': 'Hotel',
      'latlong': LatLng(51.5175, -0.1420),
    },


];
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled. Please enable them in settings.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    // When permission is granted, get the current position
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
      _mapCenter = _userLocation!; // Center the map on the user’s location
      _mapController.move(_mapCenter, _zoomLevel);
    });
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel += 1;
      _mapController.move(_mapCenter, _zoomLevel);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel -= 1;
      _mapController.move(_mapCenter, _zoomLevel);
    });
  }

  void _onMapTap(LatLng point) {
    _longPressTimer?.cancel();
  }

  void _onMapLongPress(LatLng point) {
    _longPressTimer?.cancel();
    _longPressTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _selectedLocation = point;
      });
    });
  }

  @override
  void dispose() {
    _longPressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              onTap: (tapPosition, point) {
                _onMapTap(point);
              },
              onLongPress: (tapPosition, point) {
                _onMapLongPress(point);
              },
              initialCenter: _mapCenter,
              initialZoom: _zoomLevel,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  if (_userLocation != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _userLocation!,
                      child: const Icon(
                        Icons.my_location_rounded,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                    ),
                  // Add markers for each hotel in the hotels list
                  ...hotels.map((hotel) => Marker(
                    width: 80.0,
                    height: 80.0,
                    point: hotel['latlong'], // Use hotel's coordinates
                    child: const Icon(
                      Icons.local_hotel,
                      color: Colors.purple,
                      size: 25,
                    ),
                  )),
                ],
              ),

            ],
          ),
          Positioned(
            right: 10,
            bottom: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    if (_selectedLocation != null) {
                      _addShop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a location on the map first.')),
                      );
                    }
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomIn,
                  mini: true,
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  mini: true,
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addShop() {
    // Implement shop addition logic if needed
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController = TextEditingController();
        return AlertDialog(
          title: const Text('Add New Shop'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Shop Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
