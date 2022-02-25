

import 'package:folldy_student/data/core/api_client.dart';
import 'package:folldy_student/data/data_sources/remote_data_source.dart';
import 'package:folldy_student/data/repository_implemenations/data_repository_implementation.dart';
import 'package:folldy_student/domain/repositories/data_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class DependencyInjection {
  static inject() {
    Get.lazyPut(() => ApiClient(Client()));
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSourceImplementation(Get.find()));
    Get.lazyPut<DataRepository>(() => DataRepositoryImplementation(Get.find()));
   
  }
}
