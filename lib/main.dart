import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:p_pay/hotel_page.dart';
import 'package:p_pay/utils/okto.dart';
import 'bill_page.dart';
import 'bill_provider.dart';
import 'map_page.dart';
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
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async{
    return await okto!.isLoggedIn();
  }

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
