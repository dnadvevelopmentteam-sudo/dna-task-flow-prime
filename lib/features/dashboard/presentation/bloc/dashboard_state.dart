part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class UpdatedTabIndex extends DashboardState {
  final int index;

  const UpdatedTabIndex({required this.index});

  @override
  List<Object> get props => [index];
}
