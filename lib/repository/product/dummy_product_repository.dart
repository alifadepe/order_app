import 'package:order_app/model/product.dart';
import 'package:order_app/repository/product/base_product_repository.dart';

class DummyProductRepository extends BaseProductRepository {
  final List<Product> products;

  DummyProductRepository({
    this.products = const [],
  });

  @override
  Future<List<Product>> index() async {
    await Future.delayed(const Duration(seconds: 3));
    return products;
  }

  static List<Product> generateDummyData() {
    return List.generate(10, (index) {
      return Product(
        id: index.toString(),
        name: "Product ${index + 1}",
        price: (index + 1) * 1000,
        stock: index + 10,
      );
    });
  }
}
