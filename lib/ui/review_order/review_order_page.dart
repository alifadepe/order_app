import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:order_app/bloc/review_order/review_order_bloc.dart';
import 'package:order_app/bloc/review_order/review_order_event.dart';
import 'package:order_app/bloc/review_order/review_order_state.dart';
import 'package:order_app/config/dimension_config.dart';
import 'package:order_app/model/order_item.dart';
import 'package:order_app/ui/success_order/success_order_page.dart';
import 'package:order_app/widget/basic/custom_error_widget.dart';
import 'package:order_app/widget/basic/custom_loading_widget.dart';
import 'package:order_app/widget/button/custom_main_button.dart';
import 'package:order_app/widget/item/order_item_widget.dart';

class ReviewOrderPage extends StatefulWidget {
  final List<OrderItem> orderItems;

  const ReviewOrderPage({
    Key? key,
    required this.orderItems,
  }) : super(key: key);

  @override
  State<ReviewOrderPage> createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  late ReviewOrderBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = ReviewOrderBloc(
      orderRepository: Get.find(),
    );
  }

  @override
  void dispose() {
    bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Review Order",
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<ReviewOrderBloc, ReviewOrderState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is ReviewOrderInProgress) {
          return _loading(context);
        } else if (state is ReviewOrderFailure) {
          return _failed(context, state.message);
        } else if (state is ReviewOrderInitial) {
          return _content(context);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _loading(BuildContext context) {
    return const CustomLoadingWidget();
  }

  Widget _failed(BuildContext context, String message) {
    return CustomErrorWidget(
      message: message,
      action: CustomMainButton(
        onClick: () {
          _submitOrder();
        },
        text: "Retry",
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _orderItems(context),
        ),
        _footer(context),
      ],
    );
  }

  Widget _orderItems(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConfig.horizontalMargin,
        vertical: DimensionConfig.verticalMargin,
      ),
      itemCount: widget.orderItems.length,
      itemBuilder: (context, index) {
        return _orderItemItem(context, widget.orderItems[index]);
      },
    );
  }

  Widget _orderItemItem(BuildContext context, OrderItem orderItem) {
    return OrderItemWidget(
      item: orderItem,
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, -5),
            color: HexColor("#21252A0D"),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _totalPrice(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _decline(context),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: _accept(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _totalPrice(BuildContext context) {
    int totalPrice = 0;

    for (var item in widget.orderItems) {
      totalPrice += (item.count * item.product.price);
    }

    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        "Total Price : Rp. $totalPrice",
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  Widget _decline(BuildContext context) {
    return CustomMainButton(
      text: "Decline",
      minWidth: double.infinity,
      onClick: () {
        Get.back();
      },
    );
  }

  Widget _accept(BuildContext context) {
    return CustomMainButton(
      text: "Accept",
      minWidth: double.infinity,
      onClick: () {
        _submitOrder();
      },
    );
  }

  void _submitOrder() {
    bloc.add(ReviewOrderSubmitted(
      orderItems: widget.orderItems,
      onSuccess: () {
        _goToSuccessOrderPage();
      },
    ));
  }

  void _goToSuccessOrderPage() async {
    await Get.to(() => const SuccessOrderPage());
    Get.back(result: true);
  }
}
