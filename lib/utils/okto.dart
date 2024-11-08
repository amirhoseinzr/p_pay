import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:p_pay/utils/global.dart';
//import '/Users/amirhosein/.pub-cache/hosted/pub.dev/okto_flutter_sdk-0.0.16/lib/okto_flutter_sdk.dart';

Globals globals = Globals.instance;
Okto? okto;


class OktoService {
  static final OktoService _instance = OktoService._internal();
  Okto? okto;

  factory OktoService() {
    return _instance;
  }

  OktoService._internal();

  Future<void> initializeOkto() async {
    try {
      okto = await OktoFlutterSdk.initialize(
        apiKey: dotenv.env['OKTO_API_KEY'] ?? '74e26e21-151c-4c37-8177-911cb43d1fc9',
      );
      print("Okto SDK initialized successfully.");
    } catch (e) {
      print('Failed to initialize Okto SDK: ${e.toString()}');
    }
  }
}

class OktoFlutterSdk {
  static initialize({required String apiKey}) {}
}

// Access the singleton instance
final oktoService = OktoService();
