import 'package:dartz/dartz.dart';

import '../../data/models/lean_screen_response.dart';
import '../entities/app_error.dart';

abstract class DataRepository {
  Future<Either<AppError, LearnScreenResponse>> getLearnScreenData();
}
