import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchController>();
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          onChanged: controller.query,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
