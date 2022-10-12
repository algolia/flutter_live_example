import 'package:flutter/material.dart';

import 'filters_page.dart';
import 'search_box.dart';
import 'search_hits.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const SearchBox()),
      drawer: const Drawer(child: FiltersPage()),
      body: const SearchHits(),
    );
  }
}
