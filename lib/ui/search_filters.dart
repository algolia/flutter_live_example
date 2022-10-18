import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/ui/styling.dart';
import 'package:provider/provider.dart';

import 'search_controller.dart';

class CategoriesFacets extends StatelessWidget {
  const CategoriesFacets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchController>();
    return SearchFilters(
      title: 'Categories',
      facets: controller.categories,
      onClick: controller.selectCategory,
    );
  }
}

class BrandsFacets extends StatelessWidget {
  const BrandsFacets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchController>();
    return SearchFilters(
      title: 'Brands',
      facets: controller.brands,
      onClick: controller.selectBrand,
    );
  }
}

class SearchFilters extends StatelessWidget {
  const SearchFilters({
    Key? key,
    required this.title,
    required this.facets,
    required this.onClick,
  }) : super(key: key);

  final String title;
  final Stream<List<SelectableFacet>> facets;
  final Function(String) onClick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          title,
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
        stream: facets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final facets = snapshot.data ?? [];
            return ListView.builder(
              itemCount: facets.length,
              itemBuilder: (BuildContext context, int index) =>
                  SearchFacetRow(facet: facets[index], onClick: onClick),
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
  const SearchFacetRow({super.key, required this.facet, required this.onClick});

  final SelectableFacet facet;
  final Function(String) onClick;

  @override
  Widget build(BuildContext context) {
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
      onTap: () => onClick(facet.item.value),
    );
  }
}
