import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/features/home/domain/entites/bottom_navigaton_bar_entity.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key , required this.onItemTapped});

  final Function(int) onItemTapped;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 375,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
        ) 
        ),
        shadows: [BoxShadow(
          color: Color(0x19000000),
          blurRadius: 25,
          offset: Offset(0, -2),
          spreadRadius: 0

        )
        ]
    ),
    child: Row(
      children: bottomNavigationBarItems.asMap().entries.map((e){
        var index = e.key;
        var entity = e.value;

        return Expanded(
          flex: index == selectedIndex ? 3 : 2,
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = index;
              });
              widget.onItemTapped(index);
            },
            child: NavigationBarItem(isSelected: selectedIndex == index, bottomNavigatonBarEntity: entity)));
      }).toList()
        
      
    ),
    
    );
  }
}







