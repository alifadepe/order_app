import 'package:flutter_test/flutter_test.dart';
import 'package:order_app/model/product.dart';
import 'package:order_app/widget/item/product_item_widget.dart';

void main() {
  late Product product;

  setUpAll(() {
    product = const Product(
      id: "1",
      name: "Product 1",
      price: 1000,
      stock: 10,
    );
  });

  group("Verify initial state", () {
    testWidgets(
      "The widget must display the exact product name",
      (WidgetTester tester) async {
        await tester.pumpWidget(ProductItemWidget(product: product));
        expect(find.text("Product 1"), findsOneWidget);
      },
    );

    testWidgets(
      "The widget must display the exact product price",
      (WidgetTester tester) async {
        await tester.pumpWidget(ProductItemWidget(product: product));
        expect(find.text("Rp. 1000"), findsOneWidget);
      },
    );

    testWidgets(
      "The widget must display the exact product stock",
      (WidgetTester tester) async {
        await tester.pumpWidget(ProductItemWidget(product: product));
        expect(find.text("Stock : 10"), findsOneWidget);
      },
    );

    testWidgets(
      "The number of item selected must be zero",
      (WidgetTester tester) async {
        await tester.pumpWidget(ProductItemWidget(product: product));
        expect(find.text("0"), findsOneWidget);
      },
    );

    testWidgets(
      "The number of item selected must be equal to the parameter if provided",
      (WidgetTester tester) async {
        var initialCount = 5;
        await tester.pumpWidget(ProductItemWidget(
          product: product,
          initialCount: initialCount,
        ));
        expect(find.text("5"), findsOneWidget);
      },
    );
  });

  group("Verify on state changes", () {
    testWidgets(
      "When the plus button is tapped, the number of item selected must be increase by one from initial count",
      (WidgetTester tester) async {
        var initialCount = 0;

        await tester.pumpWidget(ProductItemWidget(
          product: product,
          initialCount: initialCount,
        ));

        await tester.tap(find.text("+"));
        await tester.pumpAndSettle();
        expect(find.text("1"), findsOneWidget);
      },
    );

    testWidgets(
      "When the plus button is tapped, the number of item selected must be the same as the stock if the initial count is the same as stock",
      (WidgetTester tester) async {
        var initialCount = 10;

        await tester.pumpWidget(ProductItemWidget(
          product: product,
          initialCount: initialCount,
        ));

        await tester.tap(find.text("+"));
        await tester.pumpAndSettle();
        expect(find.text("10"), findsOneWidget);
      },
    );

    testWidgets(
      "When the minus button is tapped, the number of item selected must be decrease by one from initial count",
      (WidgetTester tester) async {
        var initialCount = 10;

        await tester.pumpWidget(ProductItemWidget(
          product: product,
          initialCount: initialCount,
        ));

        await tester.tap(find.text("-"));
        await tester.pumpAndSettle();
        expect(find.text("9"), findsOneWidget);
      },
    );

    testWidgets(
      "When the minus button is tapped, the number of item selected must be zero if the initial count is zero",
      (WidgetTester tester) async {
        var initialCount = 0;

        await tester.pumpWidget(ProductItemWidget(
          product: product,
          initialCount: initialCount,
        ));

        await tester.tap(find.text("-"));
        await tester.pumpAndSettle();
        expect(find.text("0"), findsOneWidget);
      },
    );
  });
}
