import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_pay/services_page.dart';

import 'bill_page.dart';
import 'clinic_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Map<String, String>> purchasedServices = [];

  // Pages for the BottomNavigationBar
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    // Initialize pages with updated purchasedServices list
    _pages.addAll([
      ClinicPage(),
      ServicesPage(onServicePurchased: (service) {
        setState(() {
          purchasedServices.add(service);
        });
      }),
      BillPage(purchasedServices: purchasedServices),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Clinic Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Bill & Payment',
          ),
        ],
      ),
    );
  }
}
