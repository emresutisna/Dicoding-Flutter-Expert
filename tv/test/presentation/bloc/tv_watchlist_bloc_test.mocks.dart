// Mocks generated by Mockito 5.0.16 from annotations
// in tv/test/presentation/bloc/watchlist_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/domain/entities/tv_detail.dart' as _i8;
import 'package:core/domain/repositories/tv_repository.dart' as _i2;
import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:watchlist/domain/usecases/get_watchlist_tv_status.dart' as _i4;
import 'package:watchlist/domain/usecases/remove_tv_watchlist.dart' as _i9;
import 'package:watchlist/domain/usecases/save_tv_watchlist.dart' as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvRepository_0 extends _i1.Fake implements _i2.TvRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetWatchListTvStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTvStatus extends _i1.Mock
    implements _i4.GetWatchListTvStatus {
  MockGetWatchListTvStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTvWatchlist extends _i1.Mock implements _i6.SaveTvWatchlist {
  MockSaveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i7.Failure, String>> execute(_i8.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i3.Either<_i7.Failure, String>>.value(
                  _FakeEither_1<_i7.Failure, String>()))
          as _i5.Future<_i3.Either<_i7.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTvWatchlist extends _i1.Mock implements _i9.RemoveTvWatchlist {
  MockRemoveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i7.Failure, String>> execute(_i8.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i3.Either<_i7.Failure, String>>.value(
                  _FakeEither_1<_i7.Failure, String>()))
          as _i5.Future<_i3.Either<_i7.Failure, String>>);
  @override
  String toString() => super.toString();
}