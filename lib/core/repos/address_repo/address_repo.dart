import 'package:dartz/dartz.dart';
import 'package:fruts_e_commerce/core/entites/address_entity.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart';

abstract class AddressRepo {
  Future<Either<Failure, void>> addAddress({required AddressEntity address});
  Future<Either<Failure, List<AddressEntity>>> getAddresses({required String uId});
}
