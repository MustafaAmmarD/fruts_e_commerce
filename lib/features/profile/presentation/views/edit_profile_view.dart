import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/auth/domain/repos/auth_repo.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/widgets/edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  static const routeName = 'edit_profile_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'تعديل الحساب', showBackButton: true),
        body: const SafeArea(
          child: EditProfileViewBody(),
        ),
      ),
    );
  }
}
