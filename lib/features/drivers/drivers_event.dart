import 'package:equatable/equatable.dart';

abstract class DriversEvent extends Equatable {
  const DriversEvent();

  @override
  List<Object> get props => [];
}

class GetDriversList extends DriversEvent {}
