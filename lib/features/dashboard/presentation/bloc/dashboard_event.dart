part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class TabUpdateEvent extends DashboardEvent {
  final int selectedIndex;

  const TabUpdateEvent({required this.selectedIndex});
}
