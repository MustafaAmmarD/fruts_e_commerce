import 'package:bloc/bloc.dart';
import 'package:fruts_e_commerce/features/auth/domain/entites/user_entity.dart';
import 'package:fruts_e_commerce/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());

  final AuthRepo authRepo;

  Future<void> signin(String email, String password) async {
    emit(SigninLoading());
    final result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (Failure) => emit(SigninFailure(message: Failure.message)),
      (UserEntity) => emit(SigninSuccess(userEntity: UserEntity)),
    );
  }


  Future<void> signInWithGoogle() async {
    emit(SigninLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (Failure) => emit(SigninFailure(message: Failure.message)),
      (UserEntity) => emit(SigninSuccess(userEntity: UserEntity)),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(SigninLoading());
    final result = await authRepo.signInWithFacebook();
    result.fold(
      (Failure) => emit(SigninFailure(message: Failure.message)),
      (UserEntity) => emit(SigninSuccess(userEntity: UserEntity)),
    );
  }
}
