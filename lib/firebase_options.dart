// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  
  static final env = dotenv.env;
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
  
  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['Android_Firebase_API_Key'] ?? '',
    appId: dotenv.env['Android_Firebase_App_ID'] ?? '',
    messagingSenderId: dotenv.env['Android_Firebase_Messaging_Sender_ID'] ?? '',
    projectId: dotenv.env['Android_Firebase_Project_ID'] ?? '',
    storageBucket: dotenv.env['Android_Firebase_Storage_Bucket'] ?? '',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['IOS_Firebase_API_KEY'] ?? '',
    appId: dotenv.env['IOS_Firebase_App_ID'] ?? '',
    messagingSenderId: dotenv.env['IOS_Firebase_Messaging_Sender_ID'] ?? '',
    projectId: dotenv.env['IOS_Firebase_Project_ID'] ?? '',
    storageBucket: dotenv.env['IOS_Storage_Bucket'] ?? '',
    iosBundleId: dotenv.env['_IOS_Bundle_ID'] ?? '',
  );
}
