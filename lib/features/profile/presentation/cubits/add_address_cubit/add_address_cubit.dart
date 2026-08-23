import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/address_entity.dart';
import 'package:fruts_e_commerce/core/repos/address_repo/address_repo.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit(this.addressRepo) : super(AddAddressInitial());

  final AddressRepo addressRepo;

  Future<void> addAddress({required AddressEntity address}) async {
    emit(AddAddressLoading());
    final result = await addressRepo.addAddress(address: address);
    result.fold(
      (failure) => emit(AddAddressFailure(failure.message)),
      (success) => emit(AddAddressSuccess()),
    );
  }
}
