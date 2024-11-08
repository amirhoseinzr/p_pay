import 'dart:math';
import 'package:flutter/material.dart';

import 'bill_page.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  final List<Map<String, String>> _hotels = [
    {
      'name': 'Four Seasons Hotel',
      'location': 'San Francisco at Embarcadero',
      'specialization': 'Hotel',
      '2 Bed Room Price': '110'
    },
    {
      'name': 'Hotel Vitale',
      'location': 'Embarcadero, San Francisco',
      'specialization': 'Hotel',
      '2 Bed Room Price': '240'
    },
    {
      'name': 'Bayfront Lodge',
      'location': 'Embarcadero, San Francisco',
      'specialization': 'Hotel',
      '2 Bed Room Price': '450'
    },
    {
      'name': 'Marina Bay Inn',
      'location': 'Ferry Building, San Francisco',
      'specialization': 'Hotel',
      '2 Bed Room Price': '150'
    },
    {
      'name': 'Golden Gate Suites',
      'location': 'Financial District, San Francisco',
      'specialization': 'Hotel',
      '2 Bed Room Price': '80'
    },
    {
      'name': 'Pier View Hotel',
      'location': 'Embarcadero, San Francisco',
      'specialization': 'Hotel',
      '2 Bed Room Price': '115'
    },
    {
      'name': 'Harbor Point Lodge',
      'location': 'Embarcadero, San Francisco',
      'specialization': 'Hotel',
      '2 Bed Room Price': '55'
    },
    {
      'name': 'Waterfront Inn',
      'location': 'Financial District, San Francisco',
      'specialization': 'Hotel',
      '2 Bed Room Price': '800'
    },
    {
      'name': 'The Savoy',
      'location': 'Strand, London',
      'specialization': 'Luxury Hotel',
      '2 Bed Room Price': '60'
    },
    {
      'name': 'The Ritz London',
      'location': 'Piccadilly, London',
      'specialization': 'Luxury Hotel',
      '2 Bed Room Price': '140'
    },
    {
      'name': 'Shangri-La The Shard',
      'location': 'The Shard, London Bridge',
      'specialization': 'Hotel',
      '2 Bed Room Price': '250'
    },
    {
      'name': 'Claridge\'s',
      'location': 'Brook Street, Mayfair',
      'specialization': 'Luxury Hotel',
      '2 Bed Room Price': '60'
    },
    {
      'name': 'The Langham',
      'location': 'Regent Street, London',
      'specialization': 'Hotel',
      '2 Bed Room Price': '90'
    },
  ];

  final List<Map<String, String>> _purchasedServices = [];

  void _addHotel() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController specializationController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Hotel'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Hotel Name'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: specializationController,
                decoration: const InputDecoration(labelText: 'Specialization'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: '2 Bed Room Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    locationController.text.isNotEmpty &&
                    specializationController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  setState(() {
                    _hotels.add({
                      'name': nameController.text,
                      'location': locationController.text,
                      'specialization': specializationController.text,
                      '2 Bed Room Price': priceController.text,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showRoomOptions(BuildContext context, Map<String, String> hotel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${hotel['name']} Room Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('2 Bed Room'),
                subtitle: Text('Price: ${hotel['2 Bed Room Price']} \$'),
                onTap: () => _addToBill(context, hotel, '2 Bed Room', hotel['2 Bed Room Price']!),
              ),
              ListTile(
                title: const Text('3 Bed Room'),
                subtitle: Text('Price: ${_getRandomPrice()} \$'),
                onTap: () => _addToBill(context, hotel, '3 Bed Room', _getRandomPrice()),
              ),
              ListTile(
                title: const Text('4 Bed Room'),
                subtitle: Text('Price: ${_getRandomPrice()} \$'),
                onTap: () => _addToBill(context, hotel, '4 Bed Room', _getRandomPrice()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _getRandomPrice() {
    final Random random = Random();
    return (50 + random.nextInt(451)).toString();
  }

  void _addToBill(BuildContext context, Map<String, String> hotel, String roomType, String price) {
    setState(() {
      _purchasedServices.add({
        'name': '${hotel['name']} - $roomType',
        'price': price,
      });
    });
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BillPage(purchasedServices: _purchasedServices),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotels Can be Booked by',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Image.asset(
              'assets/images/image.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _hotels.length,
              itemBuilder: (context, index) {
                final hotel = _hotels[index];
                return GestureDetector(
                  onTap: () => _showRoomOptions(context, hotel),
                  child: ListTile(
                    title: Text(hotel['name']!),
                    subtitle: Text('${hotel['location']} - ${hotel['specialization']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHotel,
        child: const Icon(Icons.add),
      ),
    );
  }
}
