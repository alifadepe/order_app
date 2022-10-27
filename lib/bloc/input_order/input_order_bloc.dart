import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/bloc/input_order/input_order_event.dart';
import 'package:order_app/bloc/input_order/input_order_state.dart';
import 'package:order_app/model/product.dart';
import 'package:order_app/repository/product/base_product_repository.dart';

class InputOrderBloc extends Bloc<InputOrderEvent, InputOrderState> {
  final BaseProductRepository _productRepository;

  InputOrderBloc({
    required BaseProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(InputOrderInProgress()) {
    _registerHandler();
  }

  void _registerHandler() {
    on<InputOrderDataRequested>(_onRequested);
  }

  void _onRequested(
    InputOrderDataRequested event,
    Emitter<InputOrderState> emit,
  ) async {
    emit(InputOrderInProgress());
    
    try {
      List<Product> products = await _productRepository.index();
      emit(InputOrderInitial(products));
    } catch (e) {
      emit(InputOrderFailure(e.toString()));
    }
  }
}
