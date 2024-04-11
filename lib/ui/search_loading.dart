import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HitsController>();
    return StreamBuilder<SearchResponse>(
      stream: controller.responses,
      builder: (context, snapshot) =>
          snapshot.hasData ? Container() : const LinearProgressIndicator(),
    );
  }
}
