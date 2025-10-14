part of 'recurring_tasks_bloc.dart';

abstract class RecurringTasksState extends Equatable {
  const RecurringTasksState();  

  @override
  List<Object> get props => [];
}
class RecurringTasksInitial extends RecurringTasksState {}
