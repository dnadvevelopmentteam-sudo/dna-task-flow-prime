import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recurring_tasks_event.dart';
part 'recurring_tasks_state.dart';

class RecurringTasksBloc extends Bloc<RecurringTasksEvent, RecurringTasksState> {
  RecurringTasksBloc() : super(RecurringTasksInitial()) {
    on<RecurringTasksEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
