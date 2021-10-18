import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../../domain/entities/tv.dart';
import '../../domain/repositories/tv_repository.dart';

class GetPopularTvs {
  final TvRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTvs();
  }
}
