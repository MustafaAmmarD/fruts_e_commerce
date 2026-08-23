class AddressEntity {
  final String id;
  final String uId;
  final String name;
  final String email;
  final String street;
  final String city;
  final String floor;

  AddressEntity({
    required this.id,
    required this.uId,
    required this.name,
    required this.email,
    required this.street,
    required this.city,
    required this.floor,
  });

  @override
  String toString() {
    return '$street, $city, الطابق: $floor';
  }
}
