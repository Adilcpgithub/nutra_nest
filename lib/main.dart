import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/LoginBloc/bloc/login_bloc.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/LoginBloc/bloc/profil_bloc/bloc/profil_bloc.dart';
import 'package:nutra_nest/blocs/image_bloc/bloc/image_bloc.dart';
import 'package:nutra_nest/blocs/search_bloc/bloc/search_bloc_bloc.dart';
import 'package:nutra_nest/blocs/signUp/bloc/sign_up_bloc.dart';
import 'package:nutra_nest/core/network/cubit/network_cubit.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/core/theme/cubit/theme_cubit.dart';
import 'package:nutra_nest/features/address/presentaion/bloc/address_bloc/address_bloc.dart';
import 'package:nutra_nest/features/cart/presentation/bloc/bloc/cart_bloc.dart';
import 'package:nutra_nest/features/home/presentation/bloc/cycle_list_bloc/bloc/cycle_list_bloc.dart';
import 'package:nutra_nest/features/home/presentation/bloc/home_product/prodoct_bloc.dart';
import 'package:nutra_nest/features/home/presentation/bloc/price_container/price_container_bloc.dart';
import 'package:nutra_nest/features/home/presentation/bloc/review/review_bloc.dart';
import 'package:nutra_nest/features/payment/presentation/blocs/user_addres/user_address_bloc.dart';
import 'package:nutra_nest/features/splash/presentation/blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/features/wishlist/presentation/bloc/bloc/wish_bloc.dart';
import 'package:nutra_nest/features/splash/presentation/page/splash_screen.dart';
import 'package:nutra_nest/page/bottom_navigation/order/data/repository/order_repository.dart';
import 'package:nutra_nest/page/bottom_navigation/order/presentation/bloc/user_order_bloc/user_order_bloc.dart';
import 'package:nutra_nest/page/user/re_auth/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDrV9PhtF0Z99fk1cj0gE-dyzKWLt8jMRs",
            authDomain: "nutranest-a6417.firebaseapp.com",
            projectId: "nutranest-a6417",
            storageBucket: "nutranest-a6417.firebasestorage.app",
            messagingSenderId: "544605270040",
            appId: "1:544605270040:web:13bfb93b297a124cfc536d",
            measurementId: "G-MWR4PF1ZT0"));
  } else {
    await Firebase.initializeApp();
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  bool status = false;
  @override
  void initState() {
    log('intitstate calling ');
    _checkUserStatus();
    super.initState();
  }

  Future<void> _checkUserStatus() async {
    UserStatus userStatus = UserStatus();
    bool loggedInStatus = await userStatus.isUserLoggedIn();
    setState(() {
      log('aaaaaaaaa $loggedInStatus');
      status = loggedInStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SplashBloc()..add(StartAnimationEvent())),
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => SignUpBloc()),
          BlocProvider(create: (context) => ProfilBloc()),
          BlocProvider(create: (context) => PriceContainerBloc()),
          BlocProvider(create: (context) => CycleBloc()),
          BlocProvider(create: (context) => SearchBlocBloc()),
          BlocProvider(create: (context) => ImageBloc()),
          BlocProvider(create: (context) => ThemeCubit()..isDartMode()),
          BlocProvider(create: (context) => NetworkCubit()),
          BlocProvider(create: (context) => CartBloc()),
          BlocProvider(create: (context) => WishBloc()),
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => AddressBloc()),
          BlocProvider(create: (context) => ProductBloc()),
          BlocProvider(create: (context) => UserAddressBloc()),
          BlocProvider(
              create: (context) =>
                  UserOrderBloc(orderRepository: OrderRepository())),
          BlocProvider(create: (_) => ReviewBloc()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
                home: SplashScreen());
          },
        ));
  }
}
