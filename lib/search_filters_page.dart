import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';

class SearchFiltersPage extends StatelessWidget {
  const SearchFiltersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Genre',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: StreamBuilder<List<SelectableFacet>>(
        stream: controller.facets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final facets = snapshot.data ?? [];
            return ListView.builder(
              itemCount: facets.length,
              itemBuilder: (BuildContext context, int index) {
                final selectable = facets[index];
                final facet = selectable.item;
                return ListTile(
                  title: Text('${facet.value} (${facet.count})'),
                  trailing:
                      selectable.isSelected ? const Icon(Icons.check) : null,
                  onTap: () => controller.selectFacet(facet.value),
                );
              },
            );
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
