import 'dart:convert';

import 'package:a_and_i_report_web_server/src/core/models/user.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/providers/delete_cached_user_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/providers/get_cached_user_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/providers/get_user_access_token_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/providers/save_cached_user_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_event.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserViewModel extends _$UserViewModel {
  @override
  UserViewState build() {
    _syncFromToken();
    return const UserViewState();
  }

  Future<void> onEvent(UserViewEvent event) async {
    switch (event) {
      case SyncFromToken():
        await _syncFromToken();
      case MyInfoFetched():
        try {
          await ref.read(saveCachedUserUsecaseProvider).call(event.user);
        } catch (_) {}
        state = state.copyWith(
          status: UserStatus.authenticated,
          user: event.user,
          role: event.user.role,
          errorMsg: null,
        );
      case ClearUser():
        try {
          await ref.read(deleteCachedUserUsecaseProvider).call();
        } catch (_) {}
        state = const UserViewState(status: UserStatus.unauthenticated);
    }
  }

  Future<void> _syncFromToken() async {
    state = state.copyWith(status: UserStatus.loading, errorMsg: null);
    try {
      final token = await ref.read(getUserAccessTokenUsecaseProvider).call();
      if (token == null || token.isEmpty) {
        state = const UserViewState(status: UserStatus.unauthenticated);
        return;
      }

      final cachedUser = await ref.read(getCachedUserUsecaseProvider).call();
      final resolvedUser = cachedUser;
      final resolvedRole = resolvedUser?.role;

      state = state.copyWith(
        status: UserStatus.authenticated,
        user: resolvedUser,
        role: resolvedRole,
        errorMsg: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserStatus.unauthenticated,
        user: null,
        errorMsg: e.toString(),
      );
    }
  }
}
