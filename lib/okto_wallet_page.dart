import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:p_pay/utils/okto.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart'; // Correct import
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv for environment variables


class OktoWalletPage extends StatefulWidget {
  const OktoWalletPage({super.key});

  @override
  _OktoWalletPageState createState() => _OktoWalletPageState();
}

class _OktoWalletPageState extends State<OktoWalletPage> {
  @override
  void initState() {
    super.initState();
    openOrCreateWallet();
  }

  Future<void> openOrCreateWallet() async {
    try {
      final walletResponse = await oktoService.okto?.createWallet();
      if (walletResponse != null) {
        print('Wallet created or opened successfully');
        // Handle wallet response here, maybe show wallet details
      } else {
        print('Failed to open or create wallet: Wallet response is null');
      }
    } catch (e) {
      print('Failed to open or create wallet: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Okto Wallet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Okto Wallet Page'),
            CircularProgressIndicator(), // Show loading indicator while opening/creating the wallet
          ],
        ),
      ),
    );
  }
}
