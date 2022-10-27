import 'package:flutter/material.dart';
import 'package:order_app/model/product.dart';

class ProductItemWidget extends StatefulWidget {
  final Product product;
  final int initialCount;
  final ValueChanged<int>? onCountChanged;

  const ProductItemWidget({
    Key? key,
    required this.product,
    this.initialCount = 0,
    this.onCountChanged,
  }) : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  late int count;

  @override
  void initState() {
    super.initState();

    count = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _name(context),
                  _price(context),
                  _stock(context),
                ],
              ),
            ),
            _counter(context),
          ],
        ),
      ),
    );
  }

  Widget _name(BuildContext context) {
    return Text(
      widget.product.name,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget _price(BuildContext context) {
    String price = widget.product.price.toString();
    return Text(
      "Rp. $price",
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget _stock(BuildContext context) {
    String stock = widget.product.stock.toString();
    return Text(
      "Stock : $stock",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget _counter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _decrement(context),
          _count(context),
          _increment(context),
        ],
      ),
    );
  }

  Widget _decrement(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: const Text("-"),
      ),
      onTap: () {
        if (count > 0) {
          setState(() {
            --count;
            widget.onCountChanged?.call(count);
          });
        }
      },
    );
  }

  Widget _count(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Text(
        count.toString(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _increment(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: const Text("+"),
      ),
      onTap: () {
        if (widget.product.stock > count) {
          setState(() {
            count++;
            widget.onCountChanged?.call(count);
          });
        }
      },
    );
  }
}
