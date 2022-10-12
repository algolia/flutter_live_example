import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_service.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({Key? key}) : super(key: key);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  @override
  Widget build(BuildContext context) {
    final searchService = context.read<SearchService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genre'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: StreamBuilder<List<SelectableFacet>>(
        stream: searchService.facets,
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
                  onTap: () => searchService.selectFacet(facet.value),
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
