// lib/blocs/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodgo_app_test/bloc/auth/auth_event.dart';
import 'package:foodgo_app_test/bloc/auth/auth_state.dart';

import 'package:foodgo_app_test/models/user_model.dart';
import 'package:foodgo_app_test/repositories/auth_repository.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc({required AuthRepository repo})
      : _repo = repo,
        super(AuthInitial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthCheckRequested>(_onCheck);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(
      AuthLoginRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _repo.login(email: e.email, password: e.password);
      emit(AuthSuccess(user));
    } on Exception catch (err) {
      emit(AuthFailure(err.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onCheck(
      AuthCheckRequested e, Emitter<AuthState> emit) async {
    final loggedIn = await _repo.isLoggedIn();
    if (loggedIn) {
      // Reconstruct a minimal user from saved prefs
      final prefs = await _repo.getAccessToken();
      emit(AuthSuccess(UserModel(
        email: '',
        accessToken: prefs ?? '',
        refreshToken: '',
      )));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogout(
      AuthLogoutRequested e, Emitter<AuthState> emit) async {
    await _repo.logout();
    emit(AuthUnauthenticated());
  }
}
