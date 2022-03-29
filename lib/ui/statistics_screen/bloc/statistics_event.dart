part of 'statistics_bloc.dart';

abstract class StatisticsEvent {
  const StatisticsEvent();
}

class StatisticsEventInitializeEvent extends StatisticsEvent {
  const StatisticsEventInitializeEvent();
}

class StatisticsEventAddStatEvent extends StatisticsEvent {
  const StatisticsEventAddStatEvent(this.stat);

  final Stat stat;
}

class StatisticsEventUpdateStatsEvent extends StatisticsEvent {
  const StatisticsEventUpdateStatsEvent();
}

class StatisticsEventUpdateStatEvent extends StatisticsEvent {
  const StatisticsEventUpdateStatEvent(this.stat);

  final Stat stat;
}

class StatisticsEventRemoveStatEvent extends StatisticsEvent {
  const StatisticsEventRemoveStatEvent(this.stat);

  final Stat stat;
}

class StatisticsEventRemoveAllStatsEvent extends StatisticsEvent {
  const StatisticsEventRemoveAllStatsEvent();
}
