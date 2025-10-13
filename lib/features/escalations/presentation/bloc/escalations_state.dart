part of 'escalations_bloc.dart';

abstract class EscalationsState extends Equatable {
  const EscalationsState();  

  @override
  List<Object> get props => [];
}
class EscalationsInitial extends EscalationsState {}
