import 'package:get/get.dart';
import 'package:order_app/repository/order/base_order_repository.dart';
import 'package:order_app/repository/order/dummy_order_repository.dart';
import 'package:order_app/repository/product/base_product_repository.dart';
import 'package:order_app/repository/product/dummy_product_repository.dart';

Future<void> setupInjector() async {
  Get.put<BaseProductRepository>(DummyProductRepository(
    products: DummyProductRepository.generateDummyData(),
  ));
  
  Get.put<BaseOrderRepository>(DummyOrderRepository());
}
