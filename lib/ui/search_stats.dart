import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/ui/styling.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';

class SearchStats extends StatelessWidget {
  const SearchStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchController>();
    return StreamBuilder<SearchResponse>(
        stream: controller.responses,
        builder: (context, snapshot) {
          return Text(
            snapshot.data?.stats() ?? '',
            style: Theme.of(context)
                .textTheme
                .overline
                ?.copyWith(color: AppColors.proton),
          );
        });
  }
}

extension ResponseExt on SearchResponse {
  String stats() {
    final buffer = StringBuffer();
    if (!exhaustiveNbHits) buffer.write("~");
    buffer.write("$nbHits hits ");
    buffer.write("in $processingTimeMS ms");
    return buffer.toString();
  }
}
