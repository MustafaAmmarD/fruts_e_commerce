import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/address_entity.dart';
import 'package:fruts_e_commerce/core/repos/address_repo/address_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.addressRepo) : super(AddressInitial());

  final AddressRepo addressRepo;

  Future<void> fetchAddresses({required String uId}) async {
    emit(AddressLoading());
    final result = await addressRepo.getAddresses(uId: uId);
    result.fold(
      (failure) => emit(AddressFailure(failure.message)),
      (addresses) => emit(AddressSuccess(addresses)),
    );
  }
}
