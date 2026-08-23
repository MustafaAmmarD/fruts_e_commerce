import 'package:fruts_e_commerce/core/entites/product_entity.dart';

ProductEntity getDummyProduct() {
  return ProductEntity(
    name: 'Apple',
    price: 2.5,
    code: 'APL123',
    description: 'Fresh and juicy apples.', // Replace with a valid File object if needed
    isFeatured: true,
    expirationMonths: 6,
    numberOfCalories: 95,
    unitAmount: 1,
    reviews: [],
    isOrganic: true,
    imageUrl: 'https://www.tasteofhome.com/wp-content/uploads/2024/10/EXPS_TOHD24_167133_SarahTramonte_6.jpg?w=700',
  );
}


List<ProductEntity> getDummyProductsList() {
  return [
    getDummyProduct(),
    getDummyProduct(),
    getDummyProduct(),
    getDummyProduct(),
  ];
}