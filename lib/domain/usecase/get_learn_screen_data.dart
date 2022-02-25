import 'package:dartz/dartz.dart';
import 'package:folldy_student/data/models/lean_screen_response.dart';
import 'package:folldy_student/domain/entities/app_error.dart';
import 'package:folldy_student/domain/entities/no_params.dart';
import 'package:folldy_student/domain/repositories/data_repository.dart';
import 'package:folldy_student/domain/usecase/usecase.dart';

class GetLearnScreenData extends UseCase<LearnScreenResponse, NoParams> {
  final DataRepository _dataRepository;
  GetLearnScreenData(this._dataRepository);
  @override
  Future<Either<AppError, LearnScreenResponse>> call(NoParams params) async {
    return await _dataRepository.getLearnScreenData();
  }
}
