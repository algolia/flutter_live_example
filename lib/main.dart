import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'search_page.dart';
import 'ui/search_controller.dart';
import 'ui/styling.dart';

void main() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) =>
        print('${record.level.name}: ${record.time}: ${record.message}'));
  }
  runApp(const SearchApp());
}

class SearchApp extends StatelessWidget {
  const SearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<SearchController>(
        create: (_) => SearchController(),
        dispose: (_, controller) => controller.dispose(),
        child: MaterialApp(
          title: 'Algolia x Flutter',
          theme: AppTheme.light(),
          home: const SearchPage(),
        ));
  }
}
