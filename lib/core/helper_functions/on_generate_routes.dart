

import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/signin_view.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/signup_view.dart';
import 'package:fruts_e_commerce/features/best_selling_fruits/presentation/views/best_selling_view.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/main_view.dart';
import 'package:fruts_e_commerce/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:fruts_e_commerce/features/splash/presentation/views/splash_view.dart';
import 'package:fruts_e_commerce/features/product_details/presentation/views/product_details_view.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/checkout_view.dart';
import 'package:fruts_e_commerce/features/search/presentation/views/search_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/orders_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/order_tracking_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/payments_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/favorites_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/about_us_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/edit_profile_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/addresses_view.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/forgot_password_view.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/verify_code_view.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/reset_password_view.dart';
import 'package:fruts_e_commerce/features/notifications/presentation/views/notifications_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(
        builder: (_) => const SplashView(),
      );

    case BestSellingView.routeName:
      return MaterialPageRoute(
        builder: (_) => const BestSellingView(),
      );
    case SigninView.routeName:
      return MaterialPageRoute(
        builder: (_) => const SigninView(),
      );

    case SignupView.routeName:
      return MaterialPageRoute(
        builder: (_) => const SignupView(),
      );
    case OnBoardingView.routeName:
      return MaterialPageRoute(
        builder: (_) => const OnBoardingView(),
      );

    case MainView.routeName:
      return MaterialPageRoute(
        builder: (_) => const MainView(),
      );
    case ProductDetailsView.routeName:
      return MaterialPageRoute(
        builder: (_) => ProductDetailsView(product: settings.arguments as ProductEntity,),
      );
    case CheckoutView.routeName:
      return MaterialPageRoute(
        builder: (_) => const CheckoutView(),
      );
    case SearchView.routeName:
      return MaterialPageRoute(
        builder: (_) => const SearchView(),
      );
    case OrdersView.routeName:
      return MaterialPageRoute(
        builder: (_) => const OrdersView(),
      );
    case OrderTrackingView.routeName:
      return MaterialPageRoute(
        builder: (_) => OrderTrackingView(order: settings.arguments as OrderEntity),
      );
    case PaymentsView.routeName:
      return MaterialPageRoute(
        builder: (_) => const PaymentsView(),
      );
    case FavoritesView.routeName:
      return MaterialPageRoute(
        builder: (_) => const FavoritesView(),
      );
    case AboutUsView.routeName:
      return MaterialPageRoute(
        builder: (_) => const AboutUsView(),
      );
    case EditProfileView.routeName:
      return MaterialPageRoute(
        builder: (_) => const EditProfileView(),
      );
    case AddressesView.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddressesView(),
      );
    case ForgotPasswordView.routeName:
      return MaterialPageRoute(
        builder: (_) => const ForgotPasswordView(),
      );
    case VerifyCodeView.routeName:
      return MaterialPageRoute(
        builder: (_) => const VerifyCodeView(),
      );
    case ResetPasswordView.routeName:
      return MaterialPageRoute(
        builder: (_) => const ResetPasswordView(),
      );
    case NotificationsView.routeName:
      return MaterialPageRoute(
        builder: (_) => const NotificationsView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}