import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:p_pay/hotel_page.dart';
import 'package:p_pay/utils/okto.dart';
import 'package:p_pay/google_login.dart';
import 'package:p_pay/home_page.dart';
import 'bill_page.dart';
import 'bill_provider.dart';
import 'map_page.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await oktoService.initializeOkto();

  // await ParticleAuth.initialize(
  //   env: 'sandbox',  // Replace with your environment, e.g., "prod" or "test"
  //   projectId: 'a10cbc4b-475f-4a27-b4a8-137cf6b84a67', // Add your Particle Network Project ID
  // );


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

  Future<bool> checkLoginStatus() async {
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
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            bool isLoggedIn = snapshot.data ?? false;
            if (isLoggedIn) {
              return const MainPage();  // Directs to MainPage with the BottomNavigationBar
            } else {
              return const LoginWithGoogle(); // Directs to the Google login page if not logged in
            }
          }
        },
      ),
    );
  }
}
