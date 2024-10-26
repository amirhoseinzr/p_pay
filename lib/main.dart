import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dfffffff);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        brightness: Brightness.light,
        dividerColor: surfaceColor,
        scaffoldBackgroundColor: Colors.grey.shade200,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {'name': 'Teeth Cleaning', 'price': '100'},
    {'name': 'Cavity Filling', 'price': '200'},
    {'name': 'Root Canal', 'price': '500'},
    {'name': 'implant', 'price': '1000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: SafeArea(child: AppBar(title: Text('' , style: TextStyle(color: Colors.black)),
        centerTitle: true,

          actions: [
            Icon(CupertinoIcons.chat_bubble),
            SizedBox(width: 10),
            Icon(CupertinoIcons.ellipsis_vertical),
          ],
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/image.jpg',
                  fit: BoxFit.contain),
              Container(
                color: Colors.black.withOpacity(.1),
              ),
            ],
          ),
        )),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(

              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/images.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.person_solid, size: 20, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          'Dr Naaeini Dental Clinic',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(CupertinoIcons.location_solid, size: 20, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          'Tehran, Iran',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Clinic Services & Prices',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(services[index]['name']!),
                  subtitle: Text('Price: \$${services[index]['price']}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _showPurchaseDialog(context, services[index]['name']!, services[index]['price']!);
                    },
                    child: Text('Buy'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context, String serviceName, String price) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Purchase'),
          content: Text('Do you want to buy $serviceName for \$$price?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Purchased $serviceName for \$$price')),
                );
              },
              child: Text('Buy'),
            ),
          ],
        );
      },
    );
  }




}


