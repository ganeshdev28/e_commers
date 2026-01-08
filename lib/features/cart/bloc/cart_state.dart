import 'package:equatable/equatable.dart';
import '../model/cart_item_model.dart';

class CartState extends Equatable {
  final List<CartItemModel> items;
  const CartState({this.items = const []});

  double get total =>
      items.fold(0, (sum, e) => sum + e.price * e.quantity);

  @override
  List<Object?> get props => [items];
}
