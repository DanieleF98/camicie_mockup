import 'dart:async';
import 'dart:developer';

import 'package:camicie_mockup/core/stats/converters/stats_builder.dart';
import 'package:camicie_mockup/core/stats/models/stat.dart';
import 'package:camicie_mockup/core/stats/stats_repository.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc(BuildContext context)
      : _statsRepository = context.read<StatsRepository>(),
        super(const StatisticsInitialState()) {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => add(const StatisticsEventUpdateStatsEvent()),
    );
    on<StatisticsEventInitializeEvent>(_onStatisticsEventInitializeEvent);
    on<StatisticsEventUpdateStatsEvent>(_onStatisticsEventUpdateStatsEvent);
    on<StatisticsEventUpdateStatEvent>(_onStatisticsEventUpdateStatEvent);
    on<StatisticsEventAddStatEvent>(_onStatisticsEventAddStatEvent);
    on<StatisticsEventRemoveStatEvent>(_onStatisticsEventRemoveStatEvent);
    on<StatisticsEventRemoveAllStatsEvent>(
      _onStatisticsEventRemoveAllStatsEvent,
    );

    add(const StatisticsEventInitializeEvent());
  }

  final StatsRepository _statsRepository;
  late final Timer _timer;

  Future<void> _onStatisticsEventInitializeEvent(
    StatisticsEventInitializeEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(const StatisticsLoadingState());
    try {
      final QuerySnapshot<dynamic> querySnapshot =
          await _statsRepository.getAllStats();
      final List<Stat> stats = <Stat>[];
      querySnapshot.docs
          .map(
            (QueryDocumentSnapshot<dynamic> doc) => stats.add(
              StatBuilder.builder(
                doc.data(),
              ),
            ),
          )
          .toList();
      emit(StatisticsLoadedState(stats));
    } catch (e) {
      showToastError(
        text: anErrorHasOccurredWithError(
          retrievingStatsLabel,
        ),
      );
      log(e.toString());
      emit(
        const StatisticsErrorState(),
      );
    }
  }

  Future<void> _onStatisticsEventUpdateStatsEvent(
    StatisticsEventUpdateStatsEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    final StatisticsState oldState = state;
    if (oldState is StatisticsLoadedState) {
      try {
        final QuerySnapshot<dynamic> querySnapshot =
            await _statsRepository.getAllStats();
        final List<Stat> stats = <Stat>[];
        querySnapshot.docs
            .map(
              (QueryDocumentSnapshot<dynamic> doc) => stats.add(
                StatBuilder.builder(
                  doc.data(),
                ),
              ),
            )
            .toList();
        emit(StatisticsLoadedState(stats));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            retrievingStatsLabel,
          ),
        );
        log(e.toString());
        emit(const StatisticsErrorState());
      }
    }
  }

  Future<void> _onStatisticsEventUpdateStatEvent(
    StatisticsEventUpdateStatEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      final StatisticsState oldState = state;
      if (oldState is StatisticsLoadedState) {
        final List<Stat> stats = oldState.stats;
        await _statsRepository.updateStat(event.stat);
        stats[stats.indexWhere(
          (Stat stat) => stat.id == event.stat.id,
        )] = event.stat;
        emit(oldState.copyWith(stats: stats));
      }
    } catch (e) {
      showToastError(
        text: anErrorHasOccurredWithError(
          updatingStatsLabel,
        ),
      );
      log(e.toString());
      emit(
        const StatisticsErrorState(),
      );
    }
  }

  Future<void> _onStatisticsEventAddStatEvent(
    StatisticsEventAddStatEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    final StatisticsState oldState = state;
    if (oldState is StatisticsLoadedState) {
      try {
        final List<Stat> stats = oldState.stats;
        final DocumentReference<dynamic> doc =
            await _statsRepository.addStat(event.stat);
        await _statsRepository.updateStat(event.stat.copyWith(id: doc.id));
        stats.add(event.stat.copyWith(id: doc.id));
        emit(oldState.copyWith(stats: stats));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            addingNewStatLabel,
          ),
        );
        log(e.toString());
        emit(
          const StatisticsErrorState(),
        );
      }
    }
  }

  Future<void> _onStatisticsEventRemoveStatEvent(
    StatisticsEventRemoveStatEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    final StatisticsState oldState = state;
    if (oldState is StatisticsLoadedState) {
      emit(const StatisticsLoadingState());
      try {
        final List<Stat> stats = oldState.stats;
        await _statsRepository.deleteStat(event.stat);
        stats.remove(event.stat);
        emit(oldState.copyWith(stats: stats));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            removingStatLabel,
          ),
        );
        log(e.toString());
        emit(
          const StatisticsErrorState(),
        );
      }
    }
  }

  Future<void> _onStatisticsEventRemoveAllStatsEvent(
    StatisticsEventRemoveAllStatsEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    final StatisticsState oldState = state;
    if (oldState is StatisticsLoadedState) {
      try {
        await _statsRepository.removeAllStats();
        emit(
          oldState.copyWith(
            stats: <Stat>[],
          ),
        );
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            removingAllStatsLabel,
          ),
        );
        log(e.toString());
        emit(
          const StatisticsErrorState(),
        );
      }
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
