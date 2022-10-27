import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/bloc/review_order/review_order_event.dart';
import 'package:order_app/bloc/review_order/review_order_state.dart';
import 'package:order_app/repository/order/base_order_repository.dart';

class ReviewOrderBloc extends Bloc<ReviewOrderEvent, ReviewOrderState> {
  final BaseOrderRepository _orderRepository;

  ReviewOrderBloc({required BaseOrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(ReviewOrderInitial()) {
    _registerHandler();
  }

  void _registerHandler() {
    on<ReviewOrderSubmitted>(_onSubmitted);
  }

  void _onSubmitted(
    ReviewOrderSubmitted event,
    Emitter<ReviewOrderState> emit,
  ) async {
    emit(ReviewOrderInProgress());

    try {
      await _orderRepository.submit(event.orderItems);
      event.onSuccess();
    } catch (e) {
      emit(ReviewOrderFailure(e.toString()));
    }
  }
}
