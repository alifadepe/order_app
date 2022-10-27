import 'package:order_app/model/product.dart';

abstract class InputOrderState {}

class InputOrderInitial extends InputOrderState {
  final List<Product> products;

  InputOrderInitial(this.products);
}

class InputOrderInProgress extends InputOrderState {}

class InputOrderFailure extends InputOrderState {
  final String message;

  InputOrderFailure(this.message);
}
