import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'designations_event.dart';
part 'designations_state.dart';

class DesignationsBloc extends Bloc<DesignationsEvent, DesignationsState> {
  DesignationsBloc() : super(DesignationsInitial()) {
    on<DesignationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
