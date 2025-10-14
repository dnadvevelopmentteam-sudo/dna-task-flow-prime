part of 'staff_management_bloc.dart';

abstract class StaffManagementState extends Equatable {
  const StaffManagementState();  

  @override
  List<Object> get props => [];
}
class StaffManagementInitial extends StaffManagementState {}
