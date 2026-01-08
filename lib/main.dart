import 'package:flipcart/core/theme/app_theme.dart';
import 'package:flipcart/core/theme/taheme_state.dart';
import 'package:flipcart/core/theme/theme_bloc.dart';
import 'package:flipcart/features/products/bloc/product_bloc.dart';
import 'package:flipcart/features/products/bloc/product_event.dart';
import 'package:flipcart/features/products/screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_bloc_observer.dart';
import 'features/cart/bloc/cart_bloc.dart';
import 'features/cart/model/cart_item_model.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
  // if (await Hive.boxExists('cartBox')) {
  //   await Hive.deleteBoxFromDisk('cartBox');
  // }
  Hive.registerAdapter(CartItemModelAdapter());
  final cartBox = await Hive.openBox<CartItemModel>('cartBox');

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(create: (_) => CartBloc(cartBox)),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc()..add(LoadProducts()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          home: const ProductListScreen(),
        );
      },
    );
  }
}
