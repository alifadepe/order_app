import 'package:order_app/model/order_item.dart';
import 'package:order_app/repository/order/base_order_repository.dart';

class DummyOrderRepository extends BaseOrderRepository {
  @override
  Future<void> submit(List<OrderItem> orderItems) async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
