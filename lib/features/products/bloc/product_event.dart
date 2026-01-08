abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class SortByName extends ProductEvent {
  final bool ascending;
  SortByName(this.ascending);
}

class SortByPrice extends ProductEvent {
  final bool ascending;
  SortByPrice(this.ascending);
}
