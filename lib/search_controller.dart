import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

class SearchController {
  final FilterState filterState = FilterState();

  late final HitsSearcher searcher = HitsSearcher(
    applicationID: 'latency',
    apiKey: '1a23398ec6339348c9a753b22aaed3cb',
    indexName: 'movies',
  )..connectFilterState(filterState);

  late final FacetList facetList = FacetList(
    searcher: searcher,
    filterState: filterState,
    attribute: 'genre',
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
  Stream<SearchResponse> get responses => searcher.responses;

  /// Facets list.
  Stream<List<SelectableFacet>> get facets => facetList.facets;

  /// Select a facet value.
  void selectFacet(String selection) => facetList.toggle(selection);

  /// Dispose of underlying resources.
  void dispose() => _components.dispose();
}
