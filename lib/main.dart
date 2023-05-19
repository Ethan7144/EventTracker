import 'package:flutter/material.dart';
import 'package:hw2/myApp/myApp.dart';

import 'database/database_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(database: await loadDatabase()));
}
