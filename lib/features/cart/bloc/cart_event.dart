import 'package:equatable/equatable.dart';
import '../../products/model/product_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final ProductModel product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final int id;
  RemoveFromCart(this.id);
}

class ChangeQuantity extends CartEvent {
  final int id;
  final int qty;
  ChangeQuantity({required this.id, required this.qty});
}
