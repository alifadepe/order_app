import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/config/dimension_config.dart';
import 'package:order_app/widget/button/custom_main_button.dart';

class SuccessOrderPage extends StatefulWidget {
  const SuccessOrderPage({Key? key}) : super(key: key);

  @override
  State<SuccessOrderPage> createState() => _SuccessOrderPageState();
}

class _SuccessOrderPageState extends State<SuccessOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConfig.horizontalMargin,
        vertical: DimensionConfig.verticalMargin,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.check,
            size: 80,
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 32,
            ),
            child: Text(
              "Your order has been successful",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomMainButton(
            onClick: () {
              Get.back();
            },
            text: "New Order",
          ),
        ],
      ),
    );
  }
}
