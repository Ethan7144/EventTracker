import 'package:firebase_core/firebase_core.dart';
import 'package:hw2/firebase/firebase_options.dart';

Future<void> setupFirebase() async {
  //Booting firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // check if app connected to a firebase server
  bool isFirebaseConnected = Firebase.apps.isNotEmpty;

  if (isFirebaseConnected) {
    print('Firebase is already connected');
  } else {
    print('Firebase is not connected yet');
  }
}
