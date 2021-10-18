import 'package:dartz/dartz.dart';
import '../../domain/entities/tv.dart';
import '../../domain/repositories/tv_repository.dart';
import '../../utils/failure.dart';

class GetNowPlayingTvs {
  final TvRepository repository;

  GetNowPlayingTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTvs();
  }
}
