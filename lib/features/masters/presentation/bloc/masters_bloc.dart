import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'masters_event.dart';
part 'masters_state.dart';

class MastersBloc extends Bloc<MastersEvent, MastersState> {
  MastersBloc() : super(MastersInitial()) {
    on<MastersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
