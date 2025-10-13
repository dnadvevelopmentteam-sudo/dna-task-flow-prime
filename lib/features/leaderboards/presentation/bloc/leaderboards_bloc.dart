import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leaderboards_event.dart';
part 'leaderboards_state.dart';

class LeaderboardsBloc extends Bloc<LeaderboardsEvent, LeaderboardsState> {
  LeaderboardsBloc() : super(LeaderboardsInitial()) {
    on<LeaderboardsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
