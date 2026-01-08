# flipcart

A new Flutter project.

Flutter 3.32.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision be698c48a6 (8 months ago) • 2025-05-19 12:59:14 -0700
Engine • revision 1881800949 (8 months ago) • 2025-05-19 10:54:07 -0700
Tools • Dart 3.8.0 • DevTools 2.45.1

final cartBox = await Hive.openBox<CartItemModel>('cartBox');
Cart data is stored locally using Hive
Data remains intact even after app restart

Box used: cartBox

lib/
 ├── app/
 │   └── app_bloc_observer.dart
 ├── core/
 │   ├── theme/
 │   └── utils/
 ├── features/
 │   ├── products/
 │   │   ├── bloc/
 │   │   ├── model/
 │   │   └── screen/
 │   └── cart/
 │       ├── bloc/
 │       ├── model/
 │       └── screen/
 ├── app_widgets/
 │   └── cart_item_tile.dart
 └── main.dart
