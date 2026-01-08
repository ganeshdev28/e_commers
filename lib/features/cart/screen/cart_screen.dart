import 'package:flipcart/app_widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_state.dart';
import '../bloc/cart_event.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (_, index) {
                    final item = state.items[index];
                    return CartItemTile(
                      item: item,
                      onIncrease: () {
                        setState(() {
                          context.read<CartBloc>().add(
                            ChangeQuantity(id: item.id, qty: item.quantity + 1),
                          );
                        });
                      },
                      onDecrease: () {
                        setState(() {
                          context.read<CartBloc>().add(
                            ChangeQuantity(id: item.id, qty: item.quantity - 1),
                          );
                        });
                      },
                      onRemove: () {
                        setState(() {
                          context.read<CartBloc>().add(RemoveFromCart(item.id));
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${state.total}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
