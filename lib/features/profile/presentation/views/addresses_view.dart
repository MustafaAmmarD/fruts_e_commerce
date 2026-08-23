import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/helper_functions/get_user.dart';
import 'package:fruts_e_commerce/core/repos/address_repo/address_repo.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/address_cubit/address_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/widgets/addresses_view_body.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  static const routeName = 'addresses_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(getIt.get<AddressRepo>())..fetchAddresses(uId: getUser().uId),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'عناويني', showBackButton: true),
        body: const SafeArea(
          child: AddressesViewBody(),
        ),
      ),
    );
  }
}
