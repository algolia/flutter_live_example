import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/styling.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';

class SearchFiltersPage extends StatelessWidget {
  const SearchFiltersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchController>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Categories',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold),
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
              itemBuilder: (BuildContext context, int index) =>
                  SearchFacetRow(facet: facets[index]),
            );
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}

class SearchFacetRow extends StatelessWidget {
  const SearchFacetRow({super.key, required this.facet});

  final SelectableFacet facet;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchController>();
    return ListTile(
      title: Row(
        children: [
          Text(facet.item.value, style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(width: 6),
          Text(facet.item.count.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: AppColors.proton)),
        ],
      ),
      trailing: facet.isSelected
          ? const Icon(Icons.check, color: AppColors.nebulaBlue)
          : null,
      onTap: () => controller.selectFacet(facet.item.value),
    );
  }
}
