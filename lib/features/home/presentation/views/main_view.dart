import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/products_view.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/home_view.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:fruts_e_commerce/features/cart/presentation/views/cart_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/profile_view.dart';


int currentViewIndex = 0;

class MainView extends StatefulWidget {// Add this line
  const MainView({super.key});

  static const routeName = 'main_view';

  @override
  State<MainView> createState() => _MainViewState();
}


class _MainViewState extends State<MainView> {
  
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: (index){
          currentViewIndex = index;
          setState(() {
          });
        },
      ),
      body: SafeArea(child: IndexedStack(
        index: currentViewIndex,
        children: [
          const HomeView(),
          const ProductsView(),
          const CartView(),
          const ProfileView(),
        ],
      ))
    );
  }
}


