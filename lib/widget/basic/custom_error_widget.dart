import 'package:flutter/material.dart';
import 'package:order_app/config/dimension_config.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final Widget? action;

  const CustomErrorWidget({
    Key? key,
    required this.message,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Icon(
            Icons.warning,
            size: 80,
            color: Theme.of(context).colorScheme.error,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          if (action != null)
            Container(
              margin: const EdgeInsets.only(
                top: 32,
              ),
              child: action!,
            ),
        ],
      ),
    );
  }
}
