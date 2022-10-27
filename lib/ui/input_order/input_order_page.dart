import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:order_app/bloc/input_order/input_order_bloc.dart';
import 'package:order_app/bloc/input_order/input_order_event.dart';
import 'package:order_app/bloc/input_order/input_order_state.dart';
import 'package:order_app/config/dimension_config.dart';
import 'package:order_app/model/order_item.dart';
import 'package:order_app/model/product.dart';
import 'package:order_app/ui/review_order/review_order_page.dart';
import 'package:order_app/widget/basic/custom_error_widget.dart';
import 'package:order_app/widget/basic/custom_loading_widget.dart';
import 'package:order_app/widget/button/custom_main_button.dart';
import 'package:order_app/widget/item/product_item_widget.dart';

class InputOrderPage extends StatefulWidget {
  const InputOrderPage({Key? key}) : super(key: key);

  @override
  State<InputOrderPage> createState() => _InputOrderPageState();
}

class _InputOrderPageState extends State<InputOrderPage> with AfterLayoutMixin {
  late InputOrderBloc bloc;

  Map<String, OrderItem> orderItems = {};

  @override
  void initState() {
    super.initState();

    bloc = InputOrderBloc(
      productRepository: Get.find(),
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

  @override
  void afterFirstLayout(BuildContext context) {
    _requestData();
  }

  void _requestData() {
    orderItems = {};
    bloc.add(InputOrderDataRequested());
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Input Order",
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<InputOrderBloc, InputOrderState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is InputOrderInProgress) {
          return _loading(context);
        } else if (state is InputOrderFailure) {
          return _failed(context, state.message);
        } else if (state is InputOrderInitial) {
          return _content(context, state.products);
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
          _requestData();
        },
        text: "Reload",
      ),
    );
  }

  Widget _content(BuildContext context, List<Product> products) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _products(context, products),
          ),
          _buttonProcessOrder(context),
        ],
      ),
    );
  }

  Widget _products(BuildContext context, List<Product> products) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConfig.horizontalMargin,
        vertical: DimensionConfig.verticalMargin,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _productItem(context, products[index]);
      },
    );
  }

  Widget _productItem(BuildContext context, Product product) {
    return ProductItemWidget(
      product: product,
      initialCount: _initialProductItemCount(product),
      onCountChanged: (value) {
        _onProductItemCountChanged(product, value);
      },
    );
  }

  int _initialProductItemCount(Product product) {
    if (orderItems.containsKey(product.id)) {
      return orderItems[product.id]!.count;
    } else {
      return 0;
    }
  }

  void _onProductItemCountChanged(Product product, int count) {
    if (orderItems.containsKey(product.id)) {
      if (count > 0) {
        orderItems[product.id]!.count = count;
      } else {
        orderItems.remove(product.id);
      }
    } else {
      orderItems[product.id] = OrderItem(
        product: product,
        count: count,
      );
    }
  }

  Widget _buttonProcessOrder(BuildContext context) {
    return Container(
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
      child: CustomMainButton(
        text: "Process Order",
        minWidth: double.infinity,
        margin: const EdgeInsets.all(16),
        onClick: () {
          _processOrder();
        },
      ),
    );
  }

  void _processOrder() async {
    List<OrderItem> items = [];

    orderItems.forEach((key, value) {
      items.add(value);
    });

    if (items.isNotEmpty) {
      _goToReviewOrderPage(items);
    } else {
      _showMessage("Order can't empty");
    }
  }

  void _goToReviewOrderPage(List<OrderItem> items) async {
    bool? result = await Get.to(() => ReviewOrderPage(orderItems: items));

    if (result != null && result) {
      _requestData();
    }
  }

  void _showMessage(String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
}
