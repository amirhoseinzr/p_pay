import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillPage extends StatelessWidget {
  final List<Map<String, String>> purchasedServices;

  BillPage({required this.purchasedServices});

  int get totalBill {
    return purchasedServices.fold(
      0,
          (sum, service) => sum + int.parse(service['price']!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill & Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Purchased Services:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: purchasedServices.length,
                itemBuilder: (context, index) {
                  final service = purchasedServices[index];
                  return ListTile(
                    title: Text(service['name']!),
                    trailing: Text('\$${service['price']}'),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              'Total Bill: \$${totalBill}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Payment logic or navigation goes here
                },
                child: Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
