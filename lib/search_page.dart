import 'package:flutter/material.dart';

import 'ui/search_box.dart';
import 'ui/search_filters.dart';
import 'ui/search_hits.dart';
import 'ui/search_stats.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) =>
      Screen.isLarge(context) ? const DesktopSearch() : const HandsetSearch();
}

class HandsetSearch extends StatelessWidget {
  const HandsetSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const SearchBox()),
      drawer: Drawer(
          child: Column(
        children: const [
          Expanded(flex: 1, child: Card(child: CategoriesFacets())),
          Expanded(flex: 1, child: Card(child: BrandsFacets())),
        ],
      )),
      body: const SearchHits(),
    );
  }
}

class DesktopSearch extends StatelessWidget {
  const DesktopSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 1280,
        height: 720,
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
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 268,
                  child: Column(
                    children: const [
                      Expanded(flex: 1, child: Card(child: CategoriesFacets())),
                      Expanded(flex: 1, child: Card(child: BrandsFacets())),
                    ],
                  ),
                ),
                const Flexible(child: SearchHits())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Screen {
  static const breakpointSM = 640;
  static const breakpointLD = 768;
  static const breakpointLG = 1024;
  static const breakpointXL = 1280;

  static bool isLarge(BuildContext context) =>
      MediaQuery.of(context).size.width > breakpointLG;

  static bool isMedium(BuildContext context) =>
      MediaQuery.of(context).size.width > breakpointSM;
}
