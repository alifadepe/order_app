abstract class ReviewOrderState {}

class ReviewOrderInitial extends ReviewOrderState {}

class ReviewOrderInProgress extends ReviewOrderState {}

class ReviewOrderFailure extends ReviewOrderState {
  final String message;

  ReviewOrderFailure(this.message);
}
