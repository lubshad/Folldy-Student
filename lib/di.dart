import 'package:basic_template/basic_template.dart';
import 'package:folldy_student/presentation/screens/batch_listing/batch_listing_controller.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/dashboard_controller.dart';
import 'package:folldy_student/presentation/screens/login_screen/auth_controller.dart';
import 'package:folldy_student/presentation/screens/subject_details/subject_details_controller.dart';
import 'package:folldy_utils/data/data_sources/remote_data_source.dart';
import 'package:folldy_utils/data/repository_implemenations/data_repository_implementation.dart';
import 'package:folldy_utils/domain/repositories/data_repository.dart';

import 'data/core/api_constants.dart';

const key = 'folldy_cache';
CacheManager instance = CacheManager(
  Config(
    key,
    stalePeriod: const Duration(days: 30),
    maxNrOfCacheObjects: 500,
    repo: JsonCacheInfoRepository(databaseName: key),
    // fileSystem: IOFileSystem(key),
    fileService: HttpFileService(),
  ),
);

class DependencyInjection {
  static inject() {
    Get.lazyPut(() => ApiClient(Client(), baseUrl: ApiConstants.baseUrl));
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSourceImplementation(Get.find()));
    Get.lazyPut<DataRepository>(() => DataRepositoryImplementation(Get.find()));
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DashboardController());
    // Get.lazyPut(() => BatchListingController());
    Get.lazyPut(() => SubjectDetailsController());
    Get.lazyPut(() => instance);
  }
}
