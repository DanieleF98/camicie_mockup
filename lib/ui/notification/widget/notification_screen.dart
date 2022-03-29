import 'package:cached_network_image/cached_network_image.dart';
import 'package:camicie_mockup/core/notification/models/notification.dart';
import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/ui/notification/bloc/notification_bloc.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:camicie_mockup/utils/widgets/dialog/custom_loader_dialog.dart';
import 'package:camicie_mockup/utils/widgets/dialog/custom_simple_dialog.dart';
import 'package:camicie_mockup/utils/widgets/dialog/full_screen_loader.dart';
import 'package:camicie_mockup/utils/widgets/dialog/quantity_picker_dialog.dart';
import 'package:camicie_mockup/utils/widgets/widget/error_and_retry.dart';
import 'package:camicie_mockup/utils/widgets/widget/slidable_with_edit_and_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoaded = false;

    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (BuildContext dialogContext, NotificationState state) {
        if (state is NotificationLoadedState) {
          final bool? isLoading = state.isLoading;
          if (isLoading == true) {
            isLoaded = true;
            showCustomLoaderDialog(dialogContext);
          } else if (isLoaded == true && isLoading == false) {
            isLoaded = false;
            const CustomLoaderAlert().dismissDialog(dialogContext);
          }
        }
      },
      builder: (BuildContext context, NotificationState state) {
        if (state is NotificationLoadedState) {
          final List<MissingModelNotification> notifications =
              state.notifications;
          if (notifications.isEmpty) {
            showToastError(text: thereAreNoMoreNotificationsLabel);
            navigateBack(context);
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (BuildContext context, int index) {
              final MissingModelNotification notification =
                  notifications[index];
              return SlidableWithEditAndDelete(
                key: Key(notification.id),
                onEditPressed: () => showQuantityPickerDialog(
                  context,
                  notification: notification,
                  title: editNotificationLabel,
                ),
                onDeletePressed: () => showCustomAlert(
                  context,
                  areYouSureToDeleteThisNotificationLabel,
                  byPressingConfirmYouWillDeleteTheNotificationLabel,
                  () {
                    context.read<NotificationBloc>().add(
                          NotificationEventRemoveNotification(
                            notification,
                          ),
                        );
                    Navigator.pop(context);
                  },
                ),
                child: Card(
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 75,
                            height: 75,
                            imageUrl: notification.imageUrl,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                notification.fabricName,
                                style: boldTextStyle.copyWith(fontSize: 32),
                              ),
                            ),
                            Text(
                              notification.size < 20
                                  ? slimSizeIsLabel(notification.size)
                                  : sizeIsLabel(
                                      notification.size,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                getTotalMissingAmountWithLabel(
                                  notification.totalAmount,
                                ),
                                style: boldTextStyle.copyWith(fontSize: 32),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is NotificationStateErrorState) {
          return Center(
            child: ErrorAndRetry(
              retryFunction: () => context.read<NotificationBloc>().add(
                    const NotificationEventInitializeNotifications(),
                  ),
            ),
          );
        } else {
          return const FullScreenLoader();
        }
      },
    );
  }
}
