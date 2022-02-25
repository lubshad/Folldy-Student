import 'package:folldy_student/data/core/api_client.dart';
import 'package:folldy_student/data/core/api_constants.dart';
import 'package:folldy_student/data/models/lean_screen_response.dart';

abstract class RemoteDataSource {
  Future<LearnScreenResponse> getLearnScreenData();
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  final ApiClient _apiClient;

  RemoteDataSourceImplementation(this._apiClient);
  @override
  Future<LearnScreenResponse> getLearnScreenData() async {
    final response = await _apiClient.post(ApiConstants.learnScreen);
    return LearnScreenResponse.fromJson(response);
  }
}
