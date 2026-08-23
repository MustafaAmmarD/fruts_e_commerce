import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/payment_card_entity.dart';
import 'package:fruts_e_commerce/core/helper_functions/get_user.dart';
import 'package:fruts_e_commerce/core/repos/payment_repo/payment_repo.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/widgets/custom_text_field.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/cubits/checkout_cubit/checkout_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/add_card_cubit/add_card_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/payment_cubit/payment_cubit.dart';
import 'package:uuid/uuid.dart';

class PaymentStep extends StatelessWidget {
  const PaymentStep({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentCubit(getIt.get<PaymentRepo>())..fetchCards(uId: getUser().uId),
        ),
        BlocProvider(
          create: (context) => AddCardCubit(getIt.get<PaymentRepo>()),
        ),
      ],
      child: const PaymentStepBody(),
    );
  }
}

class PaymentStepBody extends StatefulWidget {
  const PaymentStepBody({super.key});

  @override
  State<PaymentStepBody> createState() => _PaymentStepBodyState();
}

class _PaymentStepBodyState extends State<PaymentStepBody> {
  bool saveCard = false;
  bool showNewCardForm = false;
  PaymentCardEntity? selectedSavedCard;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController expiryController;
  late TextEditingController cvvController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    numberController = TextEditingController();
    expiryController = TextEditingController();
    cvvController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCardCubit, AddCardState>(
      listener: (context, addState) {
        if (addState is AddCardSuccess) {
          context.read<CheckoutCubit>().nextStep();
        } else if (addState is AddCardFailure) {
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
                      BlocBuilder<PaymentCubit, PaymentState>(
                        builder: (context, state) {
                          bool isListEmpty = state is PaymentSuccess && state.cards.isEmpty;
                          bool shouldShowForm = showNewCardForm || isListEmpty;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state is PaymentLoading)
                                const Center(child: CircularProgressIndicator()),
                              if (state is PaymentFailure)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(state.errMessage, style: const TextStyle(color: Colors.red)),
                                ),
                              if (state is PaymentSuccess && state.cards.isNotEmpty) ...[
                                const Text('البطاقات المحفوظة', style: AppTextStyles.bold16),
                                const SizedBox(height: 16),
                                ...state.cards.map((card) {
                                  final isSelected = selectedSavedCard?.id == card.id;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSavedCard = card;
                                        showNewCardForm = false;
                                      });
                                    },
                                    child: Card(
                                      elevation: 0,
                                      color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.1) : const Color(0xFFF9FAFA),
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
                                            Icon(Icons.credit_card, color: AppColors.primaryColor),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(card.brand, style: AppTextStyles.bold16),
                                                  const SizedBox(height: 4),
                                                  Text('**** **** **** ${card.cardNumber.length >= 4 ? card.cardNumber.substring(card.cardNumber.length - 4) : card.cardNumber}', style: AppTextStyles.regular13),
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
                                }),
                                TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      showNewCardForm = !showNewCardForm;
                                      selectedSavedCard = null;
                                    });
                                  },
                                  icon: Icon(
                                    showNewCardForm ? Icons.close : Icons.add,
                                    color: AppColors.primaryColor,
                                  ),
                                  label: Text(
                                    showNewCardForm ? 'إلغاء' : 'إضافة بطاقة جديدة',
                                    style: AppTextStyles.bold16.copyWith(color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                              if (isListEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: Text('لا توجد بطاقات محفوظة، يرجى إضافة بطاقة جديدة', style: AppTextStyles.bold16),
                                ),
                              if (shouldShowForm)
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('إضافة بطاقة جديدة', style: AppTextStyles.bold16),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        hintText: 'الاسم كامل',
                                        textInputType: TextInputType.name,
                                        controller: nameController,
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        hintText: 'رقم البطاقة',
                                        textInputType: TextInputType.number,
                                        controller: numberController,
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextFormField(
                                              hintText: 'CVV',
                                              textInputType: TextInputType.number,
                                              controller: cvvController,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: CustomTextFormField(
                                              hintText: 'تاريخ الانتهاء',
                                              textInputType: TextInputType.datetime,
                                              controller: expiryController,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Switch(
                                            value: saveCard,
                                            onChanged: (value) {
                                              setState(() {
                                                saveCard = value;
                                              });
                                            },
                                            activeColor: AppColors.primaryColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'حفظ البطاقة لطلباتي القادمة',
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
                text: 'تأكيد & استمرار',
                isLoading: addState is AddCardLoading,
                onPressed: () {
                  final paymentState = context.read<PaymentCubit>().state;
                  final isListEmpty = paymentState is PaymentSuccess && paymentState.cards.isEmpty;
                  final shouldShowForm = showNewCardForm || isListEmpty;

                  if (!shouldShowForm && selectedSavedCard != null) {
                    context.read<CheckoutCubit>().selectedPaymentCard = selectedSavedCard;
                    context.read<CheckoutCubit>().nextStep();
                  } else if (shouldShowForm && _formKey.currentState!.validate()) {
                    String number = numberController.text.trim();
                    String brand = number.startsWith('4') ? 'Visa' : 'MasterCard';
                    
                    final newCard = PaymentCardEntity(
                      id: const Uuid().v4(),
                      uId: getUser().uId,
                      cardNumber: number,
                      brand: brand,
                      expiryDate: expiryController.text.trim(),
                      isDefault: saveCard,
                    );
                    context.read<CheckoutCubit>().selectedPaymentCard = newCard;
                    
                    if (saveCard) {
                      context.read<AddCardCubit>().addCard(card: newCard);
                    } else {
                      context.read<CheckoutCubit>().nextStep();
                    }
                  } else if (!shouldShowForm && selectedSavedCard == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الرجاء اختيار بطاقة أو إضافة بطاقة جديدة')),
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
