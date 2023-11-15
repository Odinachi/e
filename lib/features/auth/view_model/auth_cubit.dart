import 'package:e/app/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authService) : super(AuthStateInit()) {
    if (authService.loggedIn) {
      emit(AuthStateSuccess());
    }
  }
  final AuthService authService;
  void register({required String email, required String password}) async {
    emit(AuthStateLoading());
    final res = await authService.register(email: email, password: password);
    if (res.registred ?? false) {
      emit(AuthStateSuccess());
    } else {
      emit(AuthStateFailed(error: res.error ?? AppString.errorText));
    }
  }

  void login({required String email, required String password}) async {
    emit(AuthStateLoading());
    final res = await authService.login(email: email, password: password);
    if (res.loggedIn ?? false) {
      emit(AuthStateSuccess());
    } else {
      emit(AuthStateFailed(error: res.error ?? AppString.errorText));
    }
  }

  void googleAuth() async {
    emit(AuthStateLoading());
    final res = await authService.loginWithGoogle();
    if (res.loggedIn ?? false) {
      emit(AuthStateSuccess());
    } else {
      emit(AuthStateFailed(error: res.error ?? AppString.errorText));
    }
  }

  void githubAuth(BuildContext context) async {
    emit(AuthStateLoading());
    final res = await authService.loginWithGithub(context);
    if (res.loggedIn ?? false) {
      emit(AuthStateSuccess());
    } else {
      emit(AuthStateFailed(error: res.error ?? AppString.errorText));
    }
  }
}
