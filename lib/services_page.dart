import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  final Function(Map<String, String>) onServicePurchased;

  ServicesPage({required this.onServicePurchased});

  final List<Map<String, String>> services = [
    {'name': 'Teeth Cleaning', 'price': '100'},
    {'name': 'Cavity Filling', 'price': '200'},
    {'name': 'Root Canal', 'price': '500'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services & Prices'),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(services[index]['name']!),
            subtitle: Text('Price: \$${services[index]['price']}'),
            trailing: ElevatedButton(
              onPressed: () {
                onServicePurchased(services[index]);
              },
              child: Text('Buy'),
            ),
          );
        },
      ),
    );
  }
}
