import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'escalations_event.dart';
part 'escalations_state.dart';

class EscalationsBloc extends Bloc<EscalationsEvent, EscalationsState> {
  EscalationsBloc() : super(EscalationsInitial()) {
    on<EscalationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
