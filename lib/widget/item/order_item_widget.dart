import 'package:flutter/material.dart';
import 'package:order_app/model/order_item.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem item;

  const OrderItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

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
                  _count(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _name(BuildContext context) {
    return Text(
      item.product.name,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget _price(BuildContext context) {
    String price = item.product.price.toString();
    return Text(
      "Rp. $price",
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget _count(BuildContext context) {
    String count = item.count.toString();
    return Text(
      "Count : $count",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
