import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timesheet_team_event.dart';
part 'timesheet_team_state.dart';

class TimesheetTeamBloc extends Bloc<TimesheetTeamEvent, TimesheetTeamState> {
  TimesheetTeamBloc() : super(TimesheetTeamInitial()) {
    on<TimesheetTeamEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
