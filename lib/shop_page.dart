import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // List to store shop information
  final List<Map<String, String>> _shops = [
    {
      'name': 'Dr. Naaeini Dental Clinic',
      'location': 'Tehran, Iran',
      'specialization': 'Dental Care, Oral Surgery',
    },
    // Add more shops here as needed
  ];

  void _addShop() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController specializationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Shop'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Shop Name'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: specializationController,
                decoration: const InputDecoration(labelText: 'Specialization'),
              ),
            ],
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
                if (nameController.text.isNotEmpty &&
                    locationController.text.isNotEmpty &&
                    specializationController.text.isNotEmpty) {
                  setState(() {
                    _shops.add({
                      'name': nameController.text,
                      'location': locationController.text,
                      'specialization': specializationController.text,
                    });
                  });
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Image.asset(
              'assets/images/image.jpg', // Replace with your image path
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _shops.length,
              itemBuilder: (context, index) {
                final shop = _shops[index];
                return ListTile(
                  title: Text(shop['name']!),
                  subtitle: Text('${shop['location']} - ${shop['specialization']}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addShop,
        child: const Icon(Icons.add),
      ),
    );
  }
}
