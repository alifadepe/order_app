import 'package:order_app/model/order_item.dart';

abstract class BaseOrderRepository {
  Future<void> submit(List<OrderItem> orderItems);
}
