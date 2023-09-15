import 'package:equatable/equatable.dart';

abstract class VehiclesEvent extends Equatable {
  const VehiclesEvent();

  @override
  List<Object> get props => [];
}

class VehiclesShowSearch extends VehiclesEvent {
  final bool show;

  const VehiclesShowSearch({required this.show});
}

class VehiclesStartSearching extends VehiclesEvent {
  final String? keyword;

  const VehiclesStartSearching({this.keyword});
}
