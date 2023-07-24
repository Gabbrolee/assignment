// states
class AppState<T> {}

class IdleAppState<T> extends AppState<T> {}

class LoadingAppState<T> extends AppState<T> {}

class LoadingMoreAppState<T> extends AppState<T> {}

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

class FetchEvent extends AppEvent {}