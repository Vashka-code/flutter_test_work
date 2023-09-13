import 'package:equatable/equatable.dart';
import 'package:flutter_test_work/models/driver_model.dart';

abstract class DriversState extends Equatable {
  const DriversState();

  @override
  List<Object?> get props => [];
}

class DriversInitial extends DriversState {}

class DriversLoading extends DriversState {}

class DriversLoaded extends DriversState {
  final List<DriverModel> driversModel;
  const DriversLoaded(this.driversModel);
}

class DriversError extends DriversState {
  final String? message;
  const DriversError(this.message);
}
