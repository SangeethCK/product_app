import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mechinetest/features/auth/logic/auth_state.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
//Login Method
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signInFetchStatus: ApiFetchStatus.loading));
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        emit(state.copyWith(signInFetchStatus: ApiFetchStatus.success));
      }
    } on FirebaseAuthException catch (e) {
      String? errorMessage;

      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-credential') {
        errorMessage =
            'The password is incorrect or the user does not have a password.';
      } else {
        errorMessage = 'An unknown error occurred';
      }

      emit(state.copyWith(
        signInFetchStatus: ApiFetchStatus.failed,
        error: errorMessage,
      ));
    } catch (e) {
      emit(state.copyWith(
        signInFetchStatus: ApiFetchStatus.failed,
        error: 'Something went wrong',
      ));
    }
  }

// Register method
  Future<void> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signUpFetchStatus: ApiFetchStatus.loading));
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        emit(state.copyWith(signUpFetchStatus: ApiFetchStatus.success));
      }
    } on FirebaseAuthException catch (e) {
      String? errorMessage;

      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An unknown error occurred';
      }

      emit(state.copyWith(
        signUpFetchStatus: ApiFetchStatus.failed,
        error: errorMessage,
      ));
    } catch (e) {
      emit(state.copyWith(
        signUpFetchStatus: ApiFetchStatus.failed,
        error: 'Something went wrong',
      ));
    }
  }
}
