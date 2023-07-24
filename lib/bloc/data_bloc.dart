import 'package:bloc/bloc.dart';

import '../model/app_state.dart';
import '../service/data_service.dart';

class DataBloc extends Bloc<AppEvent, AppState<String>> {
  final DataService service;
  DataBloc([DataService? stringService])
      : service = stringService ?? DataService(),
        super(IdleAppState()) {
    on<FetchEvent>(fetchData);
  }

  List<String> list = [];

  Future fetchData(FetchEvent event, Emitter<AppState<String>> emit) async {
    if (list.isEmpty) {
      emit(LoadingAppState());
    } else {
      emit(LoadingMoreAppState(list));
    }
    try {
      List<String> response = await service.getData();
      list.addAll(response);
      emit(SuccessListAppState(list));
      return response;
    } catch (error) {
      if (list.isEmpty) emit(FailureAppState(error));
      return;
    }
  }
}
