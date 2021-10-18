import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';

class SaveTvWatchlist {
  final TvRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
