import 'package:equatable/equatable.dart';
import 'package:flutter_test_work/models/vehicle_model.dart';

class VehiclesState extends Equatable {
  final bool? showSearch;
  final List<VehicleModel> vehiclesModel;

  const VehiclesState({this.showSearch = false, required this.vehiclesModel});

  VehiclesState copyWith({
    bool? showSearch,
    List<VehicleModel>? vehiclesModel,
  }) {
    return VehiclesState(
      showSearch: showSearch ?? this.showSearch,
      vehiclesModel: vehiclesModel ?? this.vehiclesModel,
    );
  }

  @override
  List<Object?> get props => [showSearch, vehiclesModel];
}
