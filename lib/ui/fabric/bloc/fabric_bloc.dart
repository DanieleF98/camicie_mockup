import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:camicie_mockup/core/fabric/converters/fabric_builder.dart';
import 'package:camicie_mockup/core/fabric/fabric_repository.dart';
import 'package:camicie_mockup/core/fabric/models/fabric.dart';
import 'package:camicie_mockup/core/notification/models/notification.dart';
import 'package:camicie_mockup/ui/notification/bloc/notification_bloc.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fabric_event.dart';
part 'fabric_state.dart';

class FabricBloc extends Bloc<FabricEvent, FabricState> {
  FabricBloc(BuildContext context, this.size, this.modelOfShirtEnum)
      : _fabricRepository = context.read<FabricRepository>(),
        _notificationBloc = context.read<NotificationBloc>(),
        super(FabricStateInitialState(size)) {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => add(
        const FabricEventUpdateFabrics(),
      ),
    );
    on<FabricEventInitialEvent>(_onFabricEventInitialEvent);
    on<FabricEventUpdateFabric>(_onFabricEventUpdateFabric);
    on<FabricEventUpdateFabrics>(
      _onFabricEventUpdateFabrics,
      transformer: restartable(),
    );
    on<FabricEventAddFabric>(_onFabricEventAddFabric);
    on<FabricEventRemoveFabric>(_onFabricEventRemoveFabric);
    add(const FabricEventInitialEvent());
  }

  final ModelOfShirtEnum modelOfShirtEnum;
  final int size;
  final FabricRepository _fabricRepository;
  final NotificationBloc _notificationBloc;
  late final Timer _timer;

  Future<void> _onFabricEventInitialEvent(
    FabricEventInitialEvent event,
    Emitter<FabricState> emit,
  ) async {
    emit(FabricStateInitialState(size));
    try {
      final QuerySnapshot<dynamic> querySnapshot =
          await _fabricRepository.getAllFabrics();
      final List<Fabric> fabrics = <Fabric>[];
      querySnapshot.docs.map(
        (QueryDocumentSnapshot<dynamic> doc) {
          if ((getModelEnumFromString(
                    doc.data()['ModelOfShirtEnum'] as String,
                  ) ==
                  modelOfShirtEnum) &&
              doc.data()['Size'] as int == size) {
            fabrics.add(
              FabricBuilder.builder(
                doc.data(),
              ),
            );
          }
        },
      ).toList();
      fabrics.sort(
        (Fabric a, Fabric b) => a.fabricName.toUpperCase().compareTo(
              b.fabricName.toUpperCase(),
            ),
      );
      emit(FabricStateLoadedState(fabrics));
    } catch (e) {
      showToastError(
        text: anErrorHasOccurredWithError(
          retrievingFabricLabel,
        ),
      );
      log(e.toString());
      emit(
        const FabricStateErrorState(),
      );
    }
  }

  Future<void> _onFabricEventUpdateFabric(
    FabricEventUpdateFabric event,
    Emitter<FabricState> emit,
  ) async {
    final FabricState oldState = state;
    if (oldState is FabricStateLoadedState) {
      try {
        await _fabricRepository.updateFabric(event.fabric);
        final List<Fabric> fabrics = oldState.fabrics;
        fabrics[fabrics.indexWhere(
          (Fabric element) => element.id == event.fabric.id,
        )] = event.fabric;
        emit(oldState.copyWith(fabrics: fabrics));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            retrievingFabricLabel,
          ),
        );
        log(e.toString());
        emit(
          const FabricStateErrorState(),
        );
      }
    }
  }

  Future<void> _onFabricEventUpdateFabrics(
    FabricEventUpdateFabrics event,
    Emitter<FabricState> emit,
  ) async {
    final FabricState oldState = state;
    if (oldState is FabricStateLoadedState) {
      try {
        final QuerySnapshot<dynamic> querySnapshot =
            await _fabricRepository.getAllFabrics();
        final List<Fabric> fabrics = <Fabric>[];
        querySnapshot.docs.map(
          (QueryDocumentSnapshot<dynamic> doc) {
            if ((getModelEnumFromString(
                      doc.data()['ModelOfShirtEnum'] as String,
                    ) ==
                    modelOfShirtEnum) &&
                doc.data()['Size'] as int == size) {
              fabrics.add(
                FabricBuilder.builder(
                  doc.data(),
                ),
              );
            }
          },
        ).toList();
        fabrics.sort(
          (Fabric a, Fabric b) => a.fabricName.toUpperCase().compareTo(
                b.fabricName.toUpperCase(),
              ),
        );
        emit(FabricStateLoadedState(fabrics));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            updatingFabricLabel,
          ),
        );
        log(e.toString());
        emit(const FabricStateErrorState());
      }
    }
  }

  Future<void> _onFabricEventAddFabric(
    FabricEventAddFabric event,
    Emitter<FabricState> emit,
  ) async {
    final FabricState oldState = state;
    if (oldState is FabricStateLoadedState) {
      emit(oldState.copyWith(isLoading: true));
      try {
        final DocumentReference<dynamic> doc =
            await _fabricRepository.addFabric(event.fabric);
        await _fabricRepository.updateFabric(event.fabric.copyWith(id: doc.id));
        final List<Fabric> fabrics = oldState.fabrics;
        final Fabric newFabric = event.fabric.copyWith(id: doc.id);
        fabrics.add(newFabric);
        emit(oldState.copyWith(fabrics: fabrics, isLoading: false));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            addingNewFabricLabel,
          ),
        );
        log(e.toString());
        emit(const FabricStateErrorState());
      }
    }
  }

  Future<void> _onFabricEventRemoveFabric(
    FabricEventRemoveFabric event,
    Emitter<FabricState> emit,
  ) async {
    final FabricState oldState = state;
    final NotificationState notificationState = _notificationBloc.state;
    if (oldState is FabricStateLoadedState &&
        notificationState is NotificationLoadedState) {
      emit(oldState.copyWith(isLoading: true));
      try {
        for (final MissingModelNotification item
            in notificationState.notifications) {
          if (item.fabricId == event.fabric.id) {
            _notificationBloc.add(NotificationEventRemoveNotification(item));
          }
        }
        await _fabricRepository.deleteFabric(event.fabric);
        final List<Fabric> fabrics = oldState.fabrics;
        fabrics.remove(
          event.fabric,
        );
        emit(oldState.copyWith(fabrics: fabrics, isLoading: false));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            removingFabricLabel,
          ),
        );
        log(e.toString());
        emit(const FabricStateErrorState());
      }
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
