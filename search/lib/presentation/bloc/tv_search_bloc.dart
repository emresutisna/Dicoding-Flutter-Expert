import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
part 'events/tv_search_event.dart';
part 'states/tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs _searchTvs;

  TvSearchBloc(this._searchTvs) : super(SearchEmpty());

  @override
  Stream<TvSearchState> mapEventToState(
    TvSearchEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchLoading();
      final result = await _searchTvs.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchError(failure.message);
        },
        (data) async* {
          yield SearchHasData(data);
        },
      );
    }
  }

  @override
  Stream<Transition<TvSearchEvent, TvSearchState>> transformEvents(
      events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .flatMap(transitionFn);
  }
}
