import 'package:flutter/material.dart';
import 'package:order_app/model/order_item.dart';

abstract class ReviewOrderEvent {}

class ReviewOrderSubmitted extends ReviewOrderEvent {
  final List<OrderItem> orderItems;
  final VoidCallback onSuccess;

  ReviewOrderSubmitted({
    required this.orderItems,
    required this.onSuccess,
  });
}
