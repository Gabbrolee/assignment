// states
class AppState<T> {}

class IdleAppState<T> extends AppState<T> {}

class LoadingAppState<T> extends AppState<T> {}

class EmptyAppState<T> extends AppState<T> {}

class SuccessAppState<T> extends AppState<T> {
  final T? data;
  SuccessAppState([this.data]);
}

class SuccessListAppState<T> extends AppState<T> {
  final List<T> data;
  SuccessListAppState([this.data = const []]);
}

class FailureAppState<T> extends AppState<T> {
  final dynamic error;
  FailureAppState(this.error);
  @override
  String toString() => error.toString();
}

// events
class AppEvent {}

class FetchProductEvent extends AppEvent {}