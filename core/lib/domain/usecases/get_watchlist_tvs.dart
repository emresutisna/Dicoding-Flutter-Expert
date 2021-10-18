import 'package:dartz/dartz.dart';
import '../../domain/entities/tv.dart';
import '../../domain/repositories/tv_repository.dart';
import '../../utils/failure.dart';

class GetWatchlistTvs {
  final TvRepository _repository;

  GetWatchlistTvs(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTvs();
  }
}