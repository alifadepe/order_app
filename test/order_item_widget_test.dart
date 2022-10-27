import 'package:flutter_test/flutter_test.dart';
import 'package:order_app/model/order_item.dart';
import 'package:order_app/model/product.dart';
import 'package:order_app/widget/item/order_item_widget.dart';

void main() {
  late OrderItem orderItem;

  setUpAll(() {
    Product product = const Product(
      id: "1",
      name: "Product 1",
      price: 1000,
      stock: 10,
    );

    orderItem = OrderItem(
      product: product,
      count: 5,
    );
  });

  group("Verify initial state", () {
    testWidgets(
      "The widget must display the exact product name",
      (WidgetTester tester) async {
        await tester.pumpWidget(OrderItemWidget(
          item: orderItem,
        ));
        expect(find.text("Product 1"), findsOneWidget);
      },
    );

    testWidgets(
      "The widget must display the exact product price",
      (WidgetTester tester) async {
        await tester.pumpWidget(OrderItemWidget(
          item: orderItem,
        ));
        expect(find.text("Rp. 1000"), findsOneWidget);
      },
    );

    testWidgets(
      "The widget must display the exact product stock",
      (WidgetTester tester) async {
        await tester.pumpWidget(OrderItemWidget(
          item: orderItem,
        ));
        expect(find.text("Count : 5"), findsOneWidget);
      },
    );
  });
}
