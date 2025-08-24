import 'package:flutter/material.dart';
import 'package:flutter_dog_dashboard/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('pets');
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet IoT App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}
