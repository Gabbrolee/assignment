


import 'package:bloc/bloc.dart';

import '../model/app_state.dart';
import '../service/string_list.dart';

class StringBloc extends Bloc<AppEvent, AppState<List<String>>> {
  final StringListService service;
  StringBloc([StringListService? stringService])
      : service = stringService ?? StringListService(),
        super(IdleAppState()) {
    on<FetchProductEvent>(fetchString);
  }

  Future fetchString(
      FetchProductEvent event,
      Emitter<AppState<List<String>>> emit,
      ) async {
    if (state is! SuccessListAppState<List<String>>) emit(LoadingAppState());
    try {
      List<String> stringList = await service.getStringList();
      if (stringList.isEmpty) {
        emit(EmptyAppState());
        return;
      }
      emit(SuccessListAppState(stringList.cast<List<String>>()));
      return stringList;
    } catch (error) {
      emit(FailureAppState(error));
      return;
    }
  }
}
