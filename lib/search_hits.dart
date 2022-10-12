import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_service.dart';

class SearchHits extends StatelessWidget {
  const SearchHits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchService = context.read<SearchService>();
    return StreamBuilder<SearchResponse>(
      stream: searchService.responses,
      // 4. Listen and display searchService results!
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (snapshot.hasData) {
          final response = snapshot.data ?? SearchResponse({});
          final hits = response.hits.toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 8),
                child: Text(
                  response.stats(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: hits.length,
                  itemBuilder: (BuildContext context, int index) {
                    final hit = hits[index];
                    return ListTile(
                      title: RichText(
                        text: hit.getHighlightedString('title').toTextSpan(
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      subtitle: Text((hit['genre'] as List).join(', ')),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const LinearProgressIndicator();
        }
      },
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
