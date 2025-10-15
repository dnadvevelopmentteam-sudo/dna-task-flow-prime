import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int selectedIndex = 0;

  DashboardBloc() : super(UpdatedTabIndex(index: 0)) {
    on<TabUpdateEvent>(_tabUpdateEvent);
  }

  void _tabUpdateEvent(TabUpdateEvent event, Emitter<DashboardState> emit) {
    selectedIndex = event.selectedIndex;
    emit(UpdatedTabIndex(index: selectedIndex));
  }
}
