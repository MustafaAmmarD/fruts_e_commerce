import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/address_cubit/address_cubit.dart';

class AddressesViewBody extends StatelessWidget {
  const AddressesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AddressSuccess) {
          if (state.addresses.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد عناوين محفوظة',
                style: AppTextStyles.bold16,
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.addresses.length,
            itemBuilder: (context, index) {
              final address = state.addresses[index];
              return Card(
                elevation: 0,
                color: const Color(0xFFF9FAFA),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        style: AppTextStyles.bold16,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${address.street}, ${address.city}',
                        style: AppTextStyles.regular13,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'الطابق: ${address.floor}',
                        style: AppTextStyles.regular13,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is AddressFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
