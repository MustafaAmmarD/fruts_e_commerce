import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/features/home/domain/entites/bottom_navigaton_bar_entity.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/active_item.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/in_active_item.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem ({super.key, required this.isSelected, required this.bottomNavigatonBarEntity});

  final bool isSelected;
  final BottomNavigatonBarEntity bottomNavigatonBarEntity;
  @override
  Widget build(BuildContext context) {
    return isSelected ? ActiveItem(image: bottomNavigatonBarEntity.activeImage, text: bottomNavigatonBarEntity.name) : InActiveItem(image:bottomNavigatonBarEntity.inActiveImage );
  }
}