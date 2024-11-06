// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'bill_page.dart';
//
// class HotelPage extends StatefulWidget {
//   const HotelPage({super.key});
//
//   @override
//   _HotelPageState createState() => _HotelPageState();
// }
//
// class _HotelPageState extends State<HotelPage> {
//   // Define _hotels as a final list within the state
//   final List<Map<String, String>> _hotels = [
//     {
//       'name': 'Four Seasons Hotel',
//       'location': 'San Francisco',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '110 \$'
//     },
//     {
//       'name': 'Marriott Hotel',
//       'location': 'New York',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '150 \$'
//     },
//     {
//       'name': 'Four Seasons Hotel',
//       'location': 'San Francisco at Embarcadero',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '110 \$'
//     },
//     {
//       'name': 'Hotel Vitale',
//       'location': 'Embarcadero, San Francisco',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '240 \$'
//     },
//     {
//       'name': 'Bayfront Lodge',
//       'location': 'Embarcadero, San Francisco',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '450 \$'
//     },
//     {
//       'name': 'Marina Bay Inn',
//       'location': 'Ferry Building, San Francisco',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '150 \$'
//     },
//     {
//       'name': 'Golden Gate Suites',
//       'location': 'Financial District, San Francisco',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '80 \$'
//     },
//     {
//       'name': 'Pier View Hotel',
//       'location': 'Embarcadero, San Francisco',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '115 \$'
//     },
//     {
//       'name': 'Harbor Point Lodge',
//       'location': 'Embarcadero, San Francisco',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '55 \$'
//     },
//     {
//       'name': 'Waterfront Inn',
//       'location': 'Financial District, San Francisco',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '800 \$'
//     },
//     {
//       'name': 'The Savoy',
//       'location': 'Strand, London',
//       'specialization': 'Luxury Hotel',
//       '2 Bed Room Price': '60 \$'
//     },
//     {
//       'name': 'The Ritz London',
//       'location': 'Piccadilly, London',
//       'specialization': 'Luxury Hotel',
//       '2 Bed Room Price': '140 \$'
//     },
//     {
//       'name': 'Shangri-La The Shard',
//       'location': 'The Shard, London Bridge',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '250 \$'
//     },
//     {
//       'name': 'Claridge\'s',
//       'location': 'Brook Street, Mayfair',
//       'specialization': 'Luxury Hotel',
//       '2 Bed Room Price': '60 \$'
//     },
//     {
//       'name': 'The Langham',
//       'location': 'Regent Street, London',
//       'specialization': 'Hotel',
//       '2 Bed Room Price': '90 \$'
//     },
//     // Add more hotels as needed
//   ];
//
//   final List<Map<String, String>> _selectedRooms = []; // Track selected rooms
//
//   String _getRandomPrice() {
//     final Random random = Random();
//     return (50 + random.nextInt(451)).toString();
//   }
//
//   void _showRoomOptions(BuildContext context, Map<String, String> hotel) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('${hotel['name']} Room Options'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: Text('2 Bed Room'),
//                 subtitle: Text('Price: ${hotel['2 Bed Room Price']}'),
//                 onTap: () {
//                   _addToBill(hotel['name']!, '2 Bed Room', hotel['2 Bed Room Price']!);
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text('3 Bed Room'),
//                 subtitle: Text('Price: ${_getRandomPrice()} \$'),
//                 onTap: () {
//                   _addToBill(hotel['name']!, '3 Bed Room', '${_getRandomPrice()} \$');
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _addToBill(String name, String roomType, String price) {
//     setState(() {
//       _selectedRooms.add({
//         'name': name,
//         'roomType': roomType,
//         'price': price,
//       });
//     });
//   }
//
//   void _navigateToBillPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BillPage(selectedRooms: _selectedRooms),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotels', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.receipt),
//             onPressed: _navigateToBillPage, // Go to BillPage
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _hotels.length,
//         itemBuilder: (context, index) {
//           final hotel = _hotels[index];
//           return GestureDetector(
//             onTap: () => _showRoomOptions(context, hotel),
//             child: ListTile(
//               title: Text(hotel['name']!),
//               subtitle: Text('${hotel['location']} - ${hotel['specialization']}'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
