import 'package:flutter/material.dart';
import 'package:hw2/myApp/myApp.dart';

import 'database/database_loader.dart';
import 'firebase/firebaseSetup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupFirebase();
  
  runApp(MyApp(database: await loadDatabase()));
}
