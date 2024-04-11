import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class HitsController {
  final FilterState filterState = FilterState();

  late final HitsSearcher searcher = HitsSearcher(
    applicationID: 'B1G2GM9NG0',
    apiKey: 'aadef574be1f9252bb48d4ea09b5cfe5',
    indexName: 'demo_ecommerce',
  )..connectFilterState(filterState);

  late final FacetList categoryFacetList = searcher.buildFacetList(
    filterState: filterState,
    attribute: 'categories',
  );

  late final FacetList brandFacetList = searcher.buildFacetList(
    filterState: filterState,
    attribute: 'brand',
  );

  late final _components = CompositeDisposable()
    ..add(filterState)
    ..add(searcher)
    ..add(categoryFacetList)
    ..add(brandFacetList);

  late final TextEditingController textController = TextEditingController()
    ..addListener(() => query(textController.text));

  /// Set search query.
  void query(String query) => searcher.query(query);

  /// Search responses
  late final Stream<SearchResponse> responses = searcher.responses.shareValue();

  /// Facets list.
  Stream<List<SelectableFacet>> get categories => categoryFacetList.facets;

  /// Facets list.
  Stream<List<SelectableFacet>> get brands => brandFacetList.facets;

  /// Select a facet value.
  void selectCategory(String selection) => categoryFacetList.toggle(selection);

  /// Select a facet value.
  void selectBrand(String selection) => brandFacetList.toggle(selection);

  /// Dispose of underlying resources.
  void dispose() => _components.dispose();
}
