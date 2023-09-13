import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/features/main/main_event.dart';
import 'package:flutter_test_work/features/main/main_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(const MainPageInitial(tabIndex: 0)) {
    on<MainPageEvent>((event, emit) {
      if (event is TabChange) {
        emit(MainPageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
