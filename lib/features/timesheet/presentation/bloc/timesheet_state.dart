part of 'timesheet_bloc.dart';

abstract class TimesheetState extends Equatable {
  const TimesheetState();  

  @override
  List<Object> get props => [];
}
class TimesheetInitial extends TimesheetState {}
