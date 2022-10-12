import 'package:flutter/material.dart';

import 'search_box.dart';
import 'search_filters_page.dart';
import 'search_hits.dart';
import 'styling.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) =>
      Styling.isLargeScreen(context) ? desktopView() : handsetView();

  Scaffold desktopView() {
    return Scaffold(
      appBar: AppBar(title: const SearchBox()),
      body: Row(
        children: const [
          SizedBox(width: 250, child: SearchFiltersPage()),
          Flexible(child: SearchHits())
        ],
      ),
    );
  }

  Scaffold handsetView() {
    return Scaffold(
      appBar: AppBar(title: const SearchBox()),
      drawer: const Drawer(child: SearchFiltersPage()),
      body: const SearchHits(),
    );
  }
}
