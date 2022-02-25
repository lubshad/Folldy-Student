import 'dart:io';

import 'package:folldy_student/data/data_sources/remote_data_source.dart';
import 'package:folldy_student/domain/entities/app_error.dart';
import 'package:folldy_student/data/models/lean_screen_response.dart';
import 'package:dartz/dartz.dart';
import 'package:folldy_student/domain/repositories/data_repository.dart';

class DataRepositoryImplementation extends DataRepository {
  final RemoteDataSource _remoteDataSource;

  DataRepositoryImplementation(this._remoteDataSource);
  @override
  Future<Either<AppError, LearnScreenResponse>> getLearnScreenData() async {
    try {
      final response = await _remoteDataSource.getLearnScreenData();
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
