import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClinicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinic Information'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          Container(
            width: double.infinity,
            height: 50,
            child: Image.asset(
              'assets/images/image.jpg', // Replace with your image path
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Clinic Name: Dr. Naaeini Dental Clinic', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Location: Tehran, Iran', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('Specializations: Dental Care, Oral Surgery', style: TextStyle(fontSize: 16)),
                // Additional clinic information
              ],
            ),
          ),
        ],
      ),
    );
  }
}
