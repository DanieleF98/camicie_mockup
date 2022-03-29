import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:camicie_mockup/core/notification/converters/notification_builder.dart';
import 'package:camicie_mockup/core/notification/models/notification.dart';
import 'package:camicie_mockup/core/notification/notification_repository.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(BuildContext context)
      : _notificationRepository = context.read<NotificationRepository>(),
        super(const NotificationInitialState()) {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => add(const NotificationEventUpdateNotifications()),
    );
    on<NotificationEventInitializeNotifications>(
      _onNotificationEventInitializeNotifications,
    );
    on<NotificationEventUpdateNotifications>(
      _onNotificationEventUpdateNotifications,
      transformer: restartable(),
    );
    on<NotificationEventUpdateNotification>(
      _onNotificationEventUpdateNotification,
    );
    on<NotificationEventAddNotification>(
      _onNotificationEventAddNotification,
    );
    on<NotificationEventRemoveNotification>(
      _onNotificationEventRemoveNotification,
    );
    on<NotificationEventRemoveAllNotifications>(
      _onNotificationEventRemoveAllNotifications,
    );
    add(const NotificationEventInitializeNotifications());
  }

  final NotificationRepository _notificationRepository;
  late final Timer _timer;

  Future<void> _onNotificationEventInitializeNotifications(
    NotificationEventInitializeNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoadingState());
    try {
      final QuerySnapshot<dynamic> querySnapshot =
          await _notificationRepository.getAllNotifications();
      final List<MissingModelNotification> notifications =
          <MissingModelNotification>[];
      querySnapshot.docs
          .map(
            (QueryDocumentSnapshot<dynamic> doc) => notifications.add(
              NotificationBuilder.builder(
                doc.data(),
              ),
            ),
          )
          .toList();
      notifications.sort(
        (
          MissingModelNotification firstNotification,
          MissingModelNotification secondNotification,
        ) =>
            secondNotification.totalAmount.compareTo(
          firstNotification.totalAmount,
        ),
      );
      emit(NotificationLoadedState(notifications));
    } catch (e) {
      showToastError(
        text: anErrorHasOccurredWithError(
          retrievingNotificationLabel,
        ),
      );
      log(e.toString());
      emit(
        const NotificationStateErrorState(),
      );
    }
  }

  Future<void> _onNotificationEventUpdateNotifications(
    NotificationEventUpdateNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    final NotificationState oldState = state;
    if (oldState is NotificationLoadedState) {
      try {
        final QuerySnapshot<dynamic> querySnapshot =
            await _notificationRepository.getAllNotifications();
        final List<MissingModelNotification> notifications =
            <MissingModelNotification>[];
        querySnapshot.docs
            .map(
              (QueryDocumentSnapshot<dynamic> doc) => notifications.add(
                NotificationBuilder.builder(
                  doc.data(),
                ),
              ),
            )
            .toList();
        notifications.sort(
          (
            MissingModelNotification firstNotification,
            MissingModelNotification secondNotification,
          ) =>
              secondNotification.totalAmount.compareTo(
            firstNotification.totalAmount,
          ),
        );
        emit(NotificationLoadedState(notifications));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            retrievingNotificationLabel,
          ),
        );
        log(e.toString());
        emit(const NotificationStateErrorState());
      }
    }
  }

  Future<void> _onNotificationEventUpdateNotification(
    NotificationEventUpdateNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final NotificationState oldState = state;
      if (oldState is NotificationLoadedState) {
        final List<MissingModelNotification> notifications =
            oldState.notifications;
        await _notificationRepository.updateNotification(event.notification);
        notifications[notifications.indexWhere(
          (MissingModelNotification notification) =>
              notification.id == event.notification.id,
        )] = event.notification;
        emit(oldState.copyWith(notifications: notifications));
      }
    } catch (e) {
      showToastError(
        text: anErrorHasOccurredWithError(
          updatingNotificationLabel,
        ),
      );
      log(e.toString());
      emit(
        const NotificationStateErrorState(),
      );
    }
  }

  Future<void> _onNotificationEventAddNotification(
    NotificationEventAddNotification event,
    Emitter<NotificationState> emit,
  ) async {
    final NotificationState oldState = state;
    if (oldState is NotificationLoadedState) {
      try {
        final List<MissingModelNotification> notifications =
            oldState.notifications;
        final DocumentReference<dynamic> doc =
            await _notificationRepository.addNotification(event.notification);
        await _notificationRepository
            .updateNotification(event.notification.copyWith(id: doc.id));
        notifications.add(event.notification.copyWith(id: doc.id));
        emit(oldState.copyWith(notifications: notifications));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            addingNewNotificationLabel,
          ),
        );
        log(e.toString());
        emit(
          const NotificationStateErrorState(),
        );
      }
    }
  }

  Future<void> _onNotificationEventRemoveNotification(
    NotificationEventRemoveNotification event,
    Emitter<NotificationState> emit,
  ) async {
    final NotificationState oldState = state;
    if (oldState is NotificationLoadedState) {
      emit(
        oldState.copyWith(
          isLoading: true,
        ),
      );
      try {
        final List<MissingModelNotification> notifications =
            oldState.notifications;
        await _notificationRepository
            .deleteNotification(event.missingModelNotification);
        notifications.remove(event.missingModelNotification);
        emit(oldState.copyWith(notifications: notifications, isLoading: false));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            removingNotificationLabel,
          ),
        );
        log(e.toString());
        emit(
          const NotificationStateErrorState(),
        );
      }
    }
  }

  Future<void> _onNotificationEventRemoveAllNotifications(
    NotificationEventRemoveAllNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    final NotificationState oldState = state;
    if (oldState is NotificationLoadedState) {
      try {
        await _notificationRepository.removeAllNotifications();
        emit(
          oldState.copyWith(
            notifications: <MissingModelNotification>[],
          ),
        );
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            removingAllNotificationLabel,
          ),
        );
        log(e.toString());
        emit(
          const NotificationStateErrorState(),
        );
      }
    }
  }

  int getTotalAmountOfNotificationsNumber() {
    int totalAmountOfNotifications = 0;
    if (state is NotificationLoadedState) {
      for (final MissingModelNotification notification
          in (state as NotificationLoadedState).notifications) {
        totalAmountOfNotifications += notification.totalAmount;
      }
    }
    return totalAmountOfNotifications;
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
