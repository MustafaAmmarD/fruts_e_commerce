part of 'edit_profile_cubit.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final UserEntity userEntity;
  EditProfileSuccess(this.userEntity);
}

class EditProfileFailure extends EditProfileState {
  final String errMessage;
  EditProfileFailure(this.errMessage);
}
