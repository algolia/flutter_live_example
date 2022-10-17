import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:rxdart/rxdart.dart';

class SearchController {
  final FilterState filterState = FilterState();

  late final HitsSearcher searcher = HitsSearcher(
    applicationID: 'B1G2GM9NG0',
    apiKey: 'aadef574be1f9252bb48d4ea09b5cfe5',
    indexName: 'demo_ecommerce',
  )..connectFilterState(filterState);

  late final FacetList facetList = FacetList(
    searcher: searcher,
    filterState: filterState,
    attribute: 'categories',
    operator: FilterOperator.or,
    selectionMode: SelectionMode.multiple,
  );

  late final _components = CompositeDisposable()
    ..add(filterState)
    ..add(searcher)
    ..add(facetList);

  /// Set search query.
  void query(String query) => searcher.query(query);

  /// Search responses
  late final Stream<SearchResponse> responses = searcher.responses.shareValue();

  /// Facets list.
  Stream<List<SelectableFacet>> get facets => facetList.facets;

  /// Select a facet value.
  void selectFacet(String selection) => facetList.toggle(selection);

  /// Dispose of underlying resources.
  void dispose() => _components.dispose();
}
