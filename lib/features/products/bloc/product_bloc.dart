import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/product_data.dart';
import '../model/product_model.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState(products)) {
    on<LoadProducts>((event, emit) {
      emit(ProductState(List.from(products)));
    });

    on<SortByName>((event, emit) {
      final sorted = List<ProductModel>.from(state.products)
        ..sort((a, b) => event.ascending
            ? a.name.compareTo(b.name)
            : b.name.compareTo(a.name));
      emit(ProductState(sorted));
    });

    on<SortByPrice>((event, emit) {
      final sorted = List<ProductModel>.from(state.products)
        ..sort((a, b) => event.ascending
            ? a.price.compareTo(b.price)
            : b.price.compareTo(a.price));
      emit(ProductState(sorted));
    });
  }
}
