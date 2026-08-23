import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/features/auth/domain/entites/user_entity.dart';
import 'package:fruts_e_commerce/features/auth/domain/repos/auth_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.authRepo) : super(EditProfileInitial());

  final AuthRepo authRepo;

  Future<void> updateProfile({required UserEntity user}) async {
    emit(EditProfileLoading());
    final result = await authRepo.updateUserData(user: user);
    result.fold(
      (failure) => emit(EditProfileFailure(failure.message)),
      (userEntity) => emit(EditProfileSuccess(userEntity)),
    );
  }
}
