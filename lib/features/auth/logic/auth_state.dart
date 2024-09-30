import 'package:equatable/equatable.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';

class AuthState extends Equatable {
  final ApiFetchStatus signInFetchStatus;
  final ApiFetchStatus signUpFetchStatus;
  final ApiFetchStatus firebaseLoginFetchStatus;

  final String? error;
  const AuthState(
      {this.signInFetchStatus = ApiFetchStatus.idle,
      this.signUpFetchStatus = ApiFetchStatus.idle,
      this.firebaseLoginFetchStatus = ApiFetchStatus.idle,
      this.error});

  @override
  List<Object?> get props =>
      [signInFetchStatus, signUpFetchStatus, firebaseLoginFetchStatus, error];

  AuthState copyWith({
    ApiFetchStatus? signInFetchStatus,
    ApiFetchStatus? signUpFetchStatus,
    ApiFetchStatus? firebaseLoginFetchStatus,
    String? error,
  }) =>
      AuthState(
        signInFetchStatus: signInFetchStatus ?? this.signInFetchStatus,
        signUpFetchStatus: signUpFetchStatus ?? this.signUpFetchStatus,
        firebaseLoginFetchStatus:
            firebaseLoginFetchStatus ?? this.firebaseLoginFetchStatus,
        error: error ?? this.error,
      );
}
