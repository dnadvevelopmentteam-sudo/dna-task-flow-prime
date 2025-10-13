import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notices_event.dart';
part 'notices_state.dart';

class NoticesBloc extends Bloc<NoticesEvent, NoticesState> {
  NoticesBloc() : super(NoticesInitial()) {
    on<NoticesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
