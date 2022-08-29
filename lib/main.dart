import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'search_page.dart';
import 'search_service.dart';

void main() {
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<SearchService>(
        create: (context) => SearchService(
              searcher: HitsSearcher(
                applicationID: 'latency',
                apiKey: '1a23398ec6339348c9a753b22aaed3cb',
                indexName: 'movies',
              ),
              filterState: FilterState(),
              attribute: 'genre',
              operator: FilterOperator.or,
            ),
        dispose: (context, value) => value.dispose(),
        child: MaterialApp(
          title: 'Algolia',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SearchPage(),
        ));
  }
}
