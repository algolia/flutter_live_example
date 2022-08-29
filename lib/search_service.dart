import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

class SearchService {
  // 1. Create a hits searcher.
  final HitsSearcher searcher;

  // 2. Create the component to handle the filtering logic: FilterState.
  final FilterState filterState;

  // 3.1. Create the refinement list component.
  late final FacetList facetList;

  SearchService(
      {required this.searcher,
      required this.filterState,
      required String attribute,
      required FilterOperator operator}) {
    // 4. (Optional) Configure your default filters.
    //filterState
    //  ..add(group, {Filter.facet('genre', 'Comedy')})
    //  ..add(group, {Filter.range('rating', lowerBound: 3, upperBound: 5)});

    // 5. Create a connection between the searcher and the filter state.
    searcher.connectFilterState(filterState);

    // 3.2. instantiate the refinement list.
    facetList = FacetList.create(
      searcher: searcher,
      filterState: filterState,
      attribute: attribute,
      operator: operator,
    );
  }

  /// Set search query.
  void query(String query) {
    searcher.query(query);
  }

  /// Search responses
  Stream<SearchResponse> get responses => searcher.responses;

  /// Facets list.
  Stream<List<SelectableFacet>> get facets => facetList.facets;

  /// Select a facet value.
  void selectFacet(String selection) {
    facetList.select(selection);
  }

  /// Dispose of underlying resources.
  void dispose() {
    searcher.dispose();
    filterState.dispose();
    facetList.dispose();
  }
}
