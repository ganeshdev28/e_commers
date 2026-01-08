import 'package:flipcart/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/products/model/product_model.dart';
import '../features/cart/bloc/cart_bloc.dart';
import '../features/cart/bloc/cart_event.dart';
import '../features/cart/bloc/cart_state.dart';
import '../app_widgets/app_snackbar.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);
    final theme = Theme.of(context);

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartItem = state.items.where((e) => e.id == product.id).toList();
        final quantity = cartItem.isNotEmpty ? cartItem.first.quantity : 0;

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: r.isMobile ? 1.5 : 1.6,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(product.image, fit: BoxFit.cover),
                    ),
                  ),

                  if (quantity > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _QuantityBadge(quantity: quantity),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(r.value(mobile: 10, tablet: 14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: r.font(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// Price
                    Text(
                      '₹${product.price}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: r.font(13),
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      height: r.value(mobile: 36, tablet: 40),
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          context.read<CartBloc>().add(AddToCart(product));

                          CustomSnackBar.show(
                            context: context,
                            message: '${product.name} added to cart',
                            type: SnackBarType.success,
                          );
                        },
                        child: const Text(
                          'Add',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuantityBadge extends StatelessWidget {
  final int quantity;
  const _QuantityBadge({required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        quantity.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
