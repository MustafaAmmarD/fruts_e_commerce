import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fruts_e_commerce/core/helper_functions/on_generate_routes.dart';
import 'package:fruts_e_commerce/core/services/custom_bloc_observer.dart';
import 'package:fruts_e_commerce/core/services/database_service.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/features/splash/presentation/views/splash_view.dart';
import 'package:fruts_e_commerce/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:fruts_e_commerce/features/notifications/presentation/cubits/notifications_cubit.dart';
import 'package:fruts_e_commerce/firebase_options.dart';
import 'package:fruts_e_commerce/generated/l10n.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= CustomBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  setupGetIt();
  runApp(const FrutHub());
}

class FrutHub extends StatelessWidget {
  const FrutHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => FavoritesCubit(getIt.get<DatabaseService>())),
        BlocProvider(create: (context) => NotificationsCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'cairo',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          scaffoldBackgroundColor: Colors.white,
        ),
        localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale('ar'),
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashView.routeName, 
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}