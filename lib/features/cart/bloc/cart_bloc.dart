import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../model/cart_item_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Box<CartItemModel> box;

  CartBloc(this.box) : super(CartState(items: box.values.toList())) {
    on<AddToCart>(_add);
    on<RemoveFromCart>(_remove);
    on<ChangeQuantity>(_changeQty);
  }

  void _add(AddToCart event, Emitter<CartState> emit) {
    final existing = box.get(event.product.id);
    if (existing != null) {
      existing.quantity++;
      existing.save();
    } else {
      box.put(
        event.product.id,
        CartItemModel(
          id: event.product.id,
          name: event.product.name,
          price: event.product.price,
          image: event.product.image,
        ),
      );
    }
    emit(CartState(items: box.values.toList()));
  }

  void _remove(RemoveFromCart event, Emitter<CartState> emit) {
    box.delete(event.id);
    emit(CartState(items: box.values.toList()));
  }

  void _changeQty(ChangeQuantity event, Emitter<CartState> emit) {
    final item = box.get(event.id);
    if (item != null) {
      if (event.qty <= 0) {
        box.delete(event.id);
      } else {
        item.quantity = event.qty;
        item.save();
      }
    }
    emit(CartState(items: box.values.toList()));
  }
}
