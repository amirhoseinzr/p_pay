import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  double _zoomLevel = 13.0; // Initial zoom level
  LatLng _mapCenter = LatLng(35.6892, 51.3890); // Initial center of the map
  LatLng? _selectedLocation; // To store the selected location for adding a shop
  Timer? _longPressTimer; // Timer for long press detection

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
    // Reset timer if user taps quickly
    _longPressTimer?.cancel();
  }

  void _onMapLongPress(LatLng point) {
    // Cancel any existing timer
    _longPressTimer?.cancel();

    // Start a new timer for 3 seconds
    _longPressTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _selectedLocation = point; // Update the selected location with the long press point
      });
    });
  }

  @override
  void dispose() {
    _longPressTimer?.cancel(); // Cancel the timer when the widget is disposed
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
                _onMapTap(point); // Capture the tapped location
              },
              onLongPress: (tapPosition, point) {
                _onMapLongPress(point); // Capture the long pressed location
              },
              initialCenter: _mapCenter, // Updated parameter
              initialZoom: _zoomLevel, // Updated parameter
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  if (_selectedLocation != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _selectedLocation!,
                      // Updated constructor without 'builder'
                      child: Container(
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
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
                      _addShop(); // Open dialog to add shop
                    } else {
                      // Notify user to tap on the map first
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
    // Implement your shop addition logic here
    // This can be a dialog or a new screen to input shop details
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
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // You can save the shop details and handle the location here
                // For now, just close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
