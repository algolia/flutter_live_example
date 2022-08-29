import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/filters_page.dart';
import 'package:provider/provider.dart';

import 'search_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final searchService = context.read<SearchService>();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              onChanged: searchService.query,
              // 3. Run your searchService operations
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FiltersPage()),
            ),
          )
        ],
      ),
      body: StreamBuilder<SearchResponse>(
        stream: searchService.responses,
        // 4. Listen and display searchService results!
        builder:
            (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
          if (snapshot.hasData) {
            final response = snapshot.data ?? SearchResponse({});
            final hits = response.hits.toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline6,
                            children: hit
                                .getHightlightedString('title')
                                .toTextSpans(),
                          ),
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
