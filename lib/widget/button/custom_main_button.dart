import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final EdgeInsets? margin;
  final double? height;
  final double? minWidth;

  const CustomMainButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.margin,
    this.height,
    this.minWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: MaterialButton(
        onPressed: onClick,
        minWidth: minWidth,
        height: height,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        color: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: _text(context),
      ),
    );
  }
  
  Widget _text(BuildContext context){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
