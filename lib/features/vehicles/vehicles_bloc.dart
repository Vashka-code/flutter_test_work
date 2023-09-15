import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/features/vehicles/vehicles_event.dart';
import 'package:flutter_test_work/features/vehicles/vehicles_state.dart';
import 'package:flutter_test_work/models/vehicle_model.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  List<VehicleModel> list;

  VehiclesBloc({required this.list})
      : super(VehiclesState(vehiclesModel: list)) {
    on<VehiclesEvent>((VehiclesEvent event, Emitter<VehiclesState> emit) {
      if (event is VehiclesStartSearching) {
        emit(state.copyWith(vehiclesModel: search(event.keyword)));
      }

      if (event is VehiclesShowSearch) {
        emit(state.copyWith(showSearch: event.show));
      }
    });
  }

  List<VehicleModel> search(keyword) {
    return list.where((item) => item.name.contains(keyword)).toList();
  }
}
