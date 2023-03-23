import '../../data/app_urls.dart';
import '../../data/network/network_api.dart';

class SignUpRepo {
  final NetworkApiService _apiService = NetworkApiService();

  Future<dynamic> signUpApi(
    dynamic data,
  ) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrl.signUpEndPoint,
        data,
        false,
        null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
