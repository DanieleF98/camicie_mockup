part of 'statistics_bloc.dart';

abstract class StatisticsState {
  const StatisticsState();
}

class StatisticsInitialState extends StatisticsState {
  const StatisticsInitialState();
}

class StatisticsLoadingState extends StatisticsState {
  const StatisticsLoadingState();
}

class StatisticsLoadedState extends StatisticsState {
  const StatisticsLoadedState(this.stats);

  StatisticsLoadedState copyWith({List<Stat>? stats}) =>
      StatisticsLoadedState(stats ?? this.stats);

  final List<Stat> stats;
}

class StatisticsErrorState extends StatisticsState {
  const StatisticsErrorState();
}
