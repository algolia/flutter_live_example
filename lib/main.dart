import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';
import 'search_page.dart';

void main() {
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<SearchController>(
        create: (_) => SearchController(),
        dispose: (_, controller) => controller.dispose(),
        child: MaterialApp(
          title: 'Algolia & Flutter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SearchPage(),
        ));
  }
}
