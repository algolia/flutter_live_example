import 'package:flutter/material.dart';

import 'search_box.dart';
import 'search_filters_page.dart';
import 'search_hits.dart';
import 'search_stats.dart';
import 'styling.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) =>
      Styling.isLargeScreen(context) ? desktopView() : handsetView();

  Widget desktopView() {
    return Center(
      child: SizedBox(
        width: 1280,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            elevation: 0.0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [Card(child: SearchBox()), SearchStats()],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 268, height: 512, child: Card(child: SearchFiltersPage())),
                Flexible(child: SearchHits())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget handsetView() {
    return Scaffold(
      appBar: AppBar(title: SearchBox()),
      drawer: const Drawer(child: SearchFiltersPage()),
      body: const SearchHits(),
    );
  }
}
