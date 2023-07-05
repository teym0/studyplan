import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../infrastructure/auth_repository.dart';
import '../model/user.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<UserToken?>>(
        (ref) => AuthViewModel(ref.read(authRepositoryProvider)));

class AuthViewModel extends StateNotifier<AsyncValue<UserToken?>> {
  AuthViewModel(this.authRepository) : super(const AsyncValue.loading()) {
    initialize();
  }

  AuthRepository authRepository;

  // bool get isLoggedIn => (state is AsyncData && state.value != null);

  Future<bool> login(String username, String password) async {
    final UserToken? token = await authRepository.login(username, password);
    if (token == null) {
      return false;
    }
    final pref = await SharedPreferences.getInstance();
    pref.setString("token", token.access);
    pref.setString("refresh_token", token.refresh);
    state = AsyncValue.data(token);
    return true;
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("token");
    pref.remove("refresh_token");
    _loadToken();
  }

  Future<bool> verify(UserToken userToken) async {
    final verified = await authRepository.verify(userToken.access);
    if (verified) {
      return true;
    } else {
      refreshToken(userToken);
      return false;
    }
  }

  Future<void> initialize() async {
    await _loadToken();
  }

  Future<void> _loadToken() async {
    final pref = await SharedPreferences.getInstance();
    final String? token = pref.getString("token");
    final String? refreshToken = pref.getString("refresh_token");
    if (token == null || refreshToken == null) {
      state = const AsyncValue.data(null);
    } else {
      final userToken = UserToken(refresh: refreshToken, access: token);
      final verified = await verify(userToken);
      if (verified) {
        state = AsyncValue.data(userToken);
      }
    }
  }

  Future<void> refreshToken(UserToken userToken) async {
    final token = await authRepository.refreshToken(userToken.refresh);
    if (token == null) {
      return logout();
    }
    final pref = await SharedPreferences.getInstance();
    pref.setString("token", token.access);
    pref.setString("refresh_token", token.refresh);
    state = AsyncValue.data(token);
  }
}
