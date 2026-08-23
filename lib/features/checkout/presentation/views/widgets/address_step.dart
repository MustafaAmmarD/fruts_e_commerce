import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/address_entity.dart';
import 'package:fruts_e_commerce/core/helper_functions/get_user.dart';
import 'package:fruts_e_commerce/core/repos/address_repo/address_repo.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/widgets/custom_text_field.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/cubits/checkout_cubit/checkout_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/add_address_cubit/add_address_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/address_cubit/address_cubit.dart';
import 'package:uuid/uuid.dart';

class AddressStep extends StatelessWidget {
  const AddressStep({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddressCubit(getIt.get<AddressRepo>())..fetchAddresses(uId: getUser().uId),
        ),
        BlocProvider(
          create: (context) => AddAddressCubit(getIt.get<AddressRepo>()),
        ),
      ],
      child: const AddressStepBody(),
    );
  }
}

class AddressStepBody extends StatefulWidget {
  const AddressStepBody({super.key});

  @override
  State<AddressStepBody> createState() => _AddressStepBodyState();
}

class _AddressStepBodyState extends State<AddressStepBody> {
  bool saveAddress = false;
  bool showNewAddressForm = false;
  AddressEntity? selectedSavedAddress;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController floorController;

  @override
  void initState() {
    super.initState();
    final user = getUser();
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    streetController = TextEditingController();
    cityController = TextEditingController();
    floorController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    streetController.dispose();
    cityController.dispose();
    floorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAddressCubit, AddAddressState>(
      listener: (context, addState) {
        if (addState is AddAddressSuccess) {
          // Address saved successfully, proceed to next step
          context.read<CheckoutCubit>().nextStep();
        } else if (addState is AddAddressFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(addState.errMessage)),
          );
        }
      },
      builder: (context, addState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      BlocBuilder<AddressCubit, AddressState>(
                        builder: (context, state) {
                          bool isListEmpty = state is AddressSuccess && state.addresses.isEmpty;
                          bool shouldShowForm = showNewAddressForm || isListEmpty;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state is AddressLoading)
                                const Center(child: CircularProgressIndicator()),
                              if (state is AddressFailure)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(state.errMessage, style: const TextStyle(color: Colors.red)),
                                ),
                              if (state is AddressSuccess && state.addresses.isNotEmpty) ...[
                                const Text('عناويني المحفوظة', style: AppTextStyles.bold16),
                                const SizedBox(height: 16),
                                ...state.addresses.map((address) {
                                  final isSelected = selectedSavedAddress?.id == address.id;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSavedAddress = address;
                                        showNewAddressForm = false;
                                      });
                                    },
                                    child: Card(
                                      elevation: 0,
                                      color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : const Color(0xFFF9FAFA),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 16),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(address.name, style: AppTextStyles.bold16),
                                                  const SizedBox(height: 8),
                                                  Text('${address.street}, ${address.city}', style: AppTextStyles.regular13),
                                                  Text('الطابق: ${address.floor}', style: AppTextStyles.regular13),
                                                ],
                                              ),
                                            ),
                                            if (isSelected)
                                              const Icon(Icons.check_circle, color: AppColors.primaryColor),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      showNewAddressForm = !showNewAddressForm;
                                      selectedSavedAddress = null;
                                    });
                                  },
                                  icon: Icon(
                                    showNewAddressForm ? Icons.close : Icons.add,
                                    color: AppColors.primaryColor,
                                  ),
                                  label: Text(
                                    showNewAddressForm ? 'إلغاء' : 'إضافة عنوان جديد',
                                    style: AppTextStyles.bold16.copyWith(color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                              if (isListEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: Text('لا توجد عناوين محفوظة، يرجى إضافة عنوان جديد', style: AppTextStyles.bold16),
                                ),
                              if (shouldShowForm)
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('إضافة عنوان جديد', style: AppTextStyles.bold16),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        hintText: 'الاسم كامل',
                                        textInputType: TextInputType.name,
                                        controller: nameController,
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        hintText: 'البريد الالكتروني',
                                        textInputType: TextInputType.emailAddress,
                                        controller: emailController,
                                        isReadOnly: true,
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        hintText: 'الشارع',
                                        textInputType: TextInputType.streetAddress,
                                        controller: streetController,
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        hintText: 'المدينة',
                                        textInputType: TextInputType.streetAddress,
                                        controller: cityController,
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        hintText: 'رقم الطابق , الشقه ...',
                                        textInputType: TextInputType.text,
                                        controller: floorController,
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Switch(
                                            value: saveAddress,
                                            onChanged: (value) {
                                              setState(() {
                                                saveAddress = value;
                                              });
                                            },
                                            activeColor: AppColors.primaryColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'حفظ العنوان لطلباتي القادمة',
                                            style: AppTextStyles.bold16.copyWith(
                                              color: const Color(0xFF949D9E),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: 'التالي',
                isLoading: addState is AddAddressLoading,
                onPressed: () {
                  final addressState = context.read<AddressCubit>().state;
                  final isListEmpty = addressState is AddressSuccess && addressState.addresses.isEmpty;
                  final shouldShowForm = showNewAddressForm || isListEmpty;

                  if (!shouldShowForm && selectedSavedAddress != null) {
                    // Used a saved address
                    context.read<CheckoutCubit>().selectedAddress = selectedSavedAddress;
                    context.read<CheckoutCubit>().nextStep();
                  } else if (shouldShowForm && _formKey.currentState!.validate()) {
                    // Creating a new address
                    final newAddress = AddressEntity(
                      id: const Uuid().v4(),
                      uId: getUser().uId,
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      street: streetController.text.trim(),
                      city: cityController.text.trim(),
                      floor: floorController.text.trim(),
                    );
                    context.read<CheckoutCubit>().selectedAddress = newAddress;
                    
                    if (saveAddress) {
                      // Save to Firestore, which will trigger the listener to go next
                      context.read<AddAddressCubit>().addAddress(address: newAddress);
                    } else {
                      // Don't save, just go next
                      context.read<CheckoutCubit>().nextStep();
                    }
                  } else if (!shouldShowForm && selectedSavedAddress == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الرجاء اختيار عنوان أو إضافة عنوان جديد')),
                    );
                  }
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
