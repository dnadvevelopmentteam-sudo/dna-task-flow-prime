import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timesheet_event.dart';
part 'timesheet_state.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  TimesheetBloc() : super(TimesheetInitial()) {
    on<TimesheetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
