import 'package:dio/dio.dart';

import '../../bindings/injector.dart';
import '../../core/core.dart';
import '../storage_manager/hive/hive_service.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  final HiveService _hiveService = getIt<HiveService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    final UserInfo? userInfo =
        _hiveService.readValue(StorageKeyConstants.userInfo, null);
    final String accessToken = userInfo?.accessToken ?? '';

    var customHeaders = {
      'content-type': 'application/json',
    };

    if (accessToken.trim().isNotEmpty) {
      customHeaders.addAll({
        'Authorization': "Bearer $accessToken",
      });
    }

    return customHeaders;
  }
}
