import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/features/drivers/drivers_event.dart';
import 'package:flutter_test_work/features/drivers/drivers_state.dart';
import 'package:flutter_test_work/resources/api_repository.dart';

class DriversBloc extends Bloc<DriversEvent, DriversState> {
  DriversBloc() : super(DriversInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetDriversList>((event, emit) async {
      try {
        emit(DriversLoading());
        final mList = await apiRepository.fetchDriversList();
        emit(DriversLoaded(mList));
      } on NetworkError {
        emit(
            const DriversError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
