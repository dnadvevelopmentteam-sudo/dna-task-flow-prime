import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'staff_management_event.dart';
part 'staff_management_state.dart';

class StaffManagementBloc extends Bloc<StaffManagementEvent, StaffManagementState> {
  StaffManagementBloc() : super(StaffManagementInitial()) {
    on<StaffManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
