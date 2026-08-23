class PaymentCardEntity {
  final String id;
  final String uId;
  final String cardNumber; // Full number if mock, or just last 4 digits
  final String brand; // e.g. Visa, MasterCard
  final String expiryDate; // e.g. 12/26
  final bool isDefault;

  PaymentCardEntity({
    required this.id,
    required this.uId,
    required this.cardNumber,
    required this.brand,
    required this.expiryDate,
    required this.isDefault,
  });
}
