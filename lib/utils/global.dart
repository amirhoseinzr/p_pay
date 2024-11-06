// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
//
// class Globals {
//   String buildType = dotenv.get('sandbox');
//   String oktoClientApiKey = dotenv.get('74e26e21-151c-4c37-8177-911cb43d1fc9');
//
//   static final Globals _singleton = Globals._internal();
//
//   factory Globals() {
//     return _singleton;
//   }
//
//   Globals._internal();
//
//   static Globals get instance => _singleton;
//
//   BuildType getBuildType() {
//     switch (buildType) {
//       case 'sandbox':
//         return BuildType.sandbox;
//       case 'production':
//         return BuildType.production;
//       case 'staging':
//         return BuildType.staging;
//       default:
//         return BuildType.sandbox;
//     }
//   }
//
//   String getOktoApiKey() {
//     return oktoClientApiKey;
//   }
// }


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class Globals {
  // Load environment variables correctly by name
  String buildType = dotenv.get('BUILD_TYPE', fallback: 'sandbox');
  String oktoClientApiKey = dotenv.get('OKTO_CLIENT_API_KEY', fallback: 'your_default_api_key');

  static final Globals _singleton = Globals._internal();

  factory Globals() {
    return _singleton;
  }

  Globals._internal();

  static Globals get instance => _singleton;

  BuildType getBuildType() {
    switch (buildType) {
      case 'sandbox':
        return BuildType.sandbox;
      case 'production':
        return BuildType.production;
      case 'staging':
        return BuildType.staging;
      default:
        return BuildType.sandbox;  // Fallback to sandbox if not found
    }
  }

  String getOktoApiKey() {
    return oktoClientApiKey;
  }
}
