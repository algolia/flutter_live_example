import 'package:flutter/material.dart';
import 'package:flutter_playground/styling.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = context.read<SearchController>();
    _textController.addListener(() => controller.query(_textController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: AppColors.nebulaBlue),
            hintText: 'Search for products',
            border: InputBorder.none,
            suffixIcon: _textController.text.isEmpty ? null : IconButton(
              icon: const Icon(Icons.close, color: AppColors.mars),
              color: AppColors.mars,
              onPressed: _textController.clear,
            ),
          ),
        ),
      ),
    );
  }
}
