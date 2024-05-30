import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../core/core.dart';
import '../storage_manager/hive/hive_service.dart';

@singleton
class AuthService {
  final _userInfoStreamController = BehaviorSubject<UserInfo?>();
  final talker = Talker();
  final HiveService hiveService;

  AuthService(
    this.hiveService,
  ) {
    _initialize();
  }

  @disposeMethod
  void dispose() {
    _userInfoStreamController.close();
  }

  /// Initialize AuthService
  void _initialize() async {
    // Watch UserInfo, listen to changes and add to stream
    hiveService.watch(key: StorageKeyConstants.userInfo).listen((event) {
      _userInfoStreamController.add(event.value);
    });

    // Add initial value
    _userInfoStreamController.add(hiveService.readValue(StorageKeyConstants.userInfo, null));
  }

  /// Get UserInfo Stream
  Stream<UserInfo?> get userInfoStream => _userInfoStreamController.stream;

  /// Get UserInfo
  UserInfo? get userInfo => _userInfoStreamController.value;

  /// Get access token
  String get accessToken => userInfo?.accessToken ?? '';

  /// Get refresh token
  String get refreshToken => userInfo?.refreshToken ?? '';

  /// Check if user is authenticated
  bool get isAuthenticated => accessToken.isNotEmpty;

  /// Update UserInfo
  Future<void> updateUser(UserInfo userInfo) async {
    hiveService.writeValue(StorageKeyConstants.userInfo, userInfo);
  }

  /// Remove user
  Future<void> removeUser() async {
    await hiveService.deleteValue(StorageKeyConstants.userInfo);
  }

  /// Logout
  Future<void> logout() async {
    await removeUser();
    // BuildContext? context = ref.read(appRouterContextProvider);
    // context?.goNamed(AppRoutes.login.name);
  }

  // Refresh token
  Future<bool?> refreshTokens() async {
    final currentRToken = refreshToken;
    if (currentRToken.isEmpty) {
      return false;
    }

    // TODO: Implement fetching new token here
    return null;
  }
}
