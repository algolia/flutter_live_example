import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';

class SearchHits extends StatefulWidget {
  const SearchHits({super.key});

  @override
  State<SearchHits> createState() => _SearchHitsState();
}

class _SearchHitsState extends State<SearchHits> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<HitsController>();
    return StreamBuilder<SearchResponse>(
      stream: controller.responses,
      // 4. Listen and display controller results!
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (snapshot.hasData) {
          final response = snapshot.data ?? SearchResponse({});
          final hits = response.hits.toList();
          return ListView.builder(
            itemCount: hits.length,
            itemBuilder: (context, index) => SearchHitRow(hit: hits[index]),
          );
        } else {
          return const LinearProgressIndicator();
        }
      },
    );
  }
}

class SearchHitRow extends StatelessWidget {
  const SearchHitRow({super.key, required this.hit});

  final Hit hit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: SizedBox(
                width: 76, height: 76, child: Image.network(hit['image'])),
          ),
          Expanded(
            child: ListTile(
              title: RichText(
                text: hit
                    .getHighlightedString('name')
                    .toTextSpan(style: Theme.of(context).textTheme.bodyLarge),
              ),
              subtitle: RichText(
                text: hit
                    .getHighlightedString('description')
                    .toTextSpan(style: Theme.of(context).textTheme.bodySmall),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              isThreeLine: true,
              trailing: Text(
                "\$${hit['price']}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
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
