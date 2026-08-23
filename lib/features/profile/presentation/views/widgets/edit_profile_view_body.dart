import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/helper_functions/get_user.dart';
import 'package:fruts_e_commerce/core/utils/app_images.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/widgets/custom_text_field.dart';
import 'package:fruts_e_commerce/features/auth/domain/entites/user_entity.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key});

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late UserEntity currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = getUser();
    nameController = TextEditingController(text: currentUser.name);
    emailController = TextEditingController(text: currentUser.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesProfileImage2), // Placeholder
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.grey, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 32),
            CustomTextFormField(
              hintText: 'الاسم كامل',
              textInputType: TextInputType.name,
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال الاسم';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: 'البريد الالكتروني',
              textInputType: TextInputType.emailAddress,
              controller: emailController,
              isReadOnly: true, // Email is read-only for now
            ),
            const Spacer(),
            BlocConsumer<EditProfileCubit, EditProfileState>(
              listener: (context, state) {
                if (state is EditProfileSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تحديث الحساب بنجاح')),
                  );
                  Navigator.pop(context);
                } else if (state is EditProfileFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errMessage)),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: 'حفظ التعديلات',
                  isLoading: state is EditProfileLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final updatedUser = UserEntity(
                        uId: currentUser.uId,
                        email: currentUser.email,
                        name: nameController.text.trim(),
                      );
                      context.read<EditProfileCubit>().updateProfile(user: updatedUser);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
