import 'package:flipcart/app_widgets/product_card.dart';
import 'package:flipcart/core/utils/responsive_helper.dart';
import 'package:flipcart/features/cart/screen/cart_screen.dart';
import 'package:flipcart/features/products/bloc/product_bloc.dart';
import 'package:flipcart/features/products/bloc/product_event.dart';
import 'package:flipcart/features/products/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          /// 🔃 Sort Menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              final bloc = context.read<ProductBloc>();
              if (value == 'name_asc') bloc.add(SortByName(true));
              if (value == 'name_desc') bloc.add(SortByName(false));
              if (value == 'price_asc') bloc.add(SortByPrice(true));
              if (value == 'price_desc') bloc.add(SortByPrice(false));
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'name_asc', child: Text('Name A–Z')),
              PopupMenuItem(value: 'name_desc', child: Text('Name Z–A')),
              PopupMenuItem(
                value: 'price_asc',
                child: Text('Price Low → High'),
              ),
              PopupMenuItem(
                value: 'price_desc',
                child: Text('Price High → Low'),
              ),
            ],
          ),

          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: r.value(mobile: 12, tablet: 20, desktop: 32),
          vertical: r.value(mobile: 12, tablet: 16),
        ),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            /// ✅ Empty state
            if (state.products.isEmpty) {
              return const Center(child: Text('No products available'));
            }

            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.products.length,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _gridCount(r),
                mainAxisSpacing: r.value(mobile: 12, tablet: 16),
                crossAxisSpacing: r.value(mobile: 12, tablet: 16),
                childAspectRatio: _aspectRatio(r),
              ),

              itemBuilder: (_, i) {
                return ProductCard(product: state.products[i]);
              },
            );
          },
        ),
      ),
    );
  }

  int _gridCount(AppResponsive r) {
    if (r.isDesktop) return 4;
    if (r.isTablet) return 3;
    return 2;
  }

  double _aspectRatio(AppResponsive r) {
    if (r.isDesktop) return 0.85;
    if (r.isTablet) return 0.8;
    return 0.75;
  }
}
