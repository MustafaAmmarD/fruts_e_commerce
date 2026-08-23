import 'package:fruts_e_commerce/core/utils/app_images.dart';

class BottomNavigatonBarEntity {
  final String activeImage , inActiveImage;
  final String name;

  BottomNavigatonBarEntity({required this.activeImage, required this.inActiveImage, required this.name});
}

List<BottomNavigatonBarEntity> get bottomNavigationBarItems =>[

BottomNavigatonBarEntity(
  activeImage: Assets.imagesBoldHome,
  inActiveImage: Assets.imagesOutlineHome,
  name: 'الرئيسية',
),
BottomNavigatonBarEntity(
  activeImage: Assets.imagesBoldElement,
  inActiveImage: Assets.imagesOutlineElement,
  name: 'المنتجات',
),
BottomNavigatonBarEntity(
  activeImage: Assets.imagesBoldShoppingCart,
  inActiveImage: Assets.imagesOutlineShoppingCart,
  name: 'سلة التسوق',
),
BottomNavigatonBarEntity(
  activeImage: Assets.imagesBoldUser,
  inActiveImage: Assets.imagesOutlineUser,
  name: 'حسابي',
),

];