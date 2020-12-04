import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/search/repository/search_repository.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;

  SearchBloc({@required SearchRepository searchRepository})
      : assert(searchRepository != null),
        _searchRepository = searchRepository,
        super(const SearchState.init());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchBySearchTerm) {
      yield SearchState.loading();

      var videos = await _searchRepository.search(searchTerm: event.searchTerm);
      if (videos == null) {
        yield SearchState.error("Could not get videos");
      } else {
        yield SearchState.success(videos);
      }
    }
  }
}
