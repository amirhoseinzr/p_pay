// import 'package:flutter/material.dart';
// import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
// import 'package:p_pay/utils/okto.dart';
// import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
//
//
// class BillPage extends StatelessWidget {
//   final List<Map<String, String>> purchasedServices;
//
//   const BillPage({super.key, required this.purchasedServices});
//
//
//
//   int get totalBill {
//     return purchasedServices.fold(
//       0,
//           (sum, service) => sum + int.parse(service['price']!),
//     );
//   }
//
//
//
//   Future<void> openCryptoPayment() async {
//     try {
//       final walletResponse = await okto?.createWallet();
//       if (walletResponse != null) {
//         print('Wallet created or opened successfully');
//       } else {
//         print('Failed to open or create wallet: Wallet response is null');
//       }
//     } catch (e) {
//       print('Failed to open or create wallet: ${e.toString()}');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bill & Payment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Purchased Services:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: purchasedServices.length,
//                 itemBuilder: (context, index) {
//                   final service = purchasedServices[index];
//                   return ListTile(
//                     title: Text(service['name']!),
//                     trailing: Text('\$${service['price']}'),
//                   );
//                 },
//               ),
//             ),
//             const Divider(),
//             Text(
//               'Total Bill: \$$totalBill',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => openCryptoPayment(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                   ),
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         'assets/images/img.png', // Path to your PNG file
//                         height: 24,  // Adjust the size as needed
//                         width: 24,
//                       ),
//                       const SizedBox(width: 6), // Space between image and text
//                       const Text(
//                         'Crypto Payment',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 8), // Space between buttons
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to fiat payment or process payment logic
//                   },
//                   child: Row(
//                     children: [
//                       const Icon(Icons.attach_money), // Dollar icon
//                       const SizedBox(width: 4), // Space between icon and text
//                       const Text('Fiat Payment'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:p_pay/utils/okto.dart';
import 'package:p_pay/okto_wallet_page.dart';

class BillPage extends StatefulWidget {
  final List<Map<String, String>> purchasedServices;

  const BillPage({super.key, required this.purchasedServices});

  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  void initState() {
    super.initState();
    oktoService.initializeOkto();
  }

  int get totalBill {
    return widget.purchasedServices.fold(
      0,
          (sum, service) => sum + int.parse(service['price']!),
    );
  }

  void navigateToOktoWalletPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OktoWalletPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill & Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Purchased Services:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.purchasedServices.length,
                itemBuilder: (context, index) {
                  final service = widget.purchasedServices[index];
                  return ListTile(
                    title: Text(service['name']!),
                    trailing: Text('\$${service['price']}'),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              'Total Bill: \$$totalBill',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: navigateToOktoWalletPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/img.png', // Path to your PNG file
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Crypto Payment',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to fiat payment or add logic for fiat payment
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(width: 4),
                      const Text('Fiat Payment'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
