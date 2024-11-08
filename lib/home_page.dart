// import 'package:flutter/material.dart';
// import 'package:p_pay/google_login.dart';
// import 'package:p_pay/utils/okto.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff5166EE),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               margin: const EdgeInsets.all(40),
//               child: const Text(
//                 'Home Page',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await okto!.logout();
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const LoginWithGoogle(),
//                     ),
//                   );
//                 } catch (e) {
//                   print("Logout failed: $e");
//                 }
//               },
//               child: const Text(
//                 'Logout',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
// import 'package:p_pay/hotel_page.dart';
// import 'package:p_pay/utils/okto.dart';
// import 'bill_page.dart';
// import 'bill_provider.dart';
// import 'map_page.dart';
// import 'package:provider/provider.dart';
// import 'google_login.dart'; // Ensure this import is available
// import 'package:particle_auth/particle_auth.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   okto = Okto(globals.getOktoApiKey(), globals.getBuildType());
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BillProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Hotel App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MainPage(),
//     );
//   }
// }
//
// class MainPage extends StatefulWidget {
//   const MainPage({super.key});
//
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   int _currentIndex = 0;
//   List<Map<String, String>> purchasedServices = [];
//
//   final List<Widget> _pages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _pages.addAll([
//       const HotelPage(),
//       BillPage(purchasedServices: purchasedServices),
//       MapPage(), // OpenStreetMap page
//     ]);
//   }
//
//   Future<void> _logout() async {
//     try {
//       await okto!.logout();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginWithGoogle()),
//       );
//     } catch (e) {
//       print("Logout failed: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotel App'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.red),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.hotel),
//             label: 'Hotel List',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.receipt),
//             label: 'Bill & Payment',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map),
//             label: 'Map',
//           ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:p_pay/hotel_page.dart';
import 'package:p_pay/utils/okto.dart';
import 'bill_page.dart';
import 'bill_provider.dart';
import 'map_page.dart';
import 'google_login.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  okto = Okto(globals.getOktoApiKey(), globals.getBuildType());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BillProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Map<String, String>> purchasedServices = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      const HotelPage(),
      BillPage(purchasedServices: purchasedServices),
      MapPage(), // OpenStreetMap page
    ]);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: _logout,
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Hotel List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Bill & Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
      ),
    );
  }
}

class _logout {
}

