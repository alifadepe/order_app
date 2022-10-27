import 'package:flutter/material.dart';
import 'package:order_app/config/dimension_config.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConfig.horizontalMargin,
        vertical: DimensionConfig.verticalMargin,
      ),
      child: const CircularProgressIndicator(),
    );
  }
}