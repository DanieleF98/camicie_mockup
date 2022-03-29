import 'package:camicie_mockup/core/notification/models/notification.dart';
import 'package:camicie_mockup/ui/main/main_navigation/bloc/main_navigation_bloc.dart';
import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/ui/notification/bloc/notification_bloc.dart';
import 'package:camicie_mockup/utils/colors.dart';
import 'package:camicie_mockup/utils/dimensions.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:camicie_mockup/utils/widgets/dialog/custom_simple_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNotificationButton extends StatelessWidget {
  const CustomNotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainNavigationState navigationState =
        context.watch<MainNavigationBloc>().state;
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (BuildContext context, NotificationState state) {
        if (state is NotificationLoadedState) {
          final List<MissingModelNotification> notifications =
              state.notifications;
          final int totalAmountOfNotifications = context
              .read<NotificationBloc>()
              .getTotalAmountOfNotificationsNumber();
          return Center(
            child: Stack(
              children: <Widget>[
                if (navigationState.navigationPage ==
                    NavigationPage.notificationScreen)
                  IconButton(
                    onPressed: () => showCustomAlert(
                      context,
                      areYouSureToDeleteAllNotificationsLabel,
                      byPressingConfirmYouWillDeleteAllTheNotificationsLabel,
                      () {
                        context.read<NotificationBloc>().add(
                              const NotificationEventRemoveAllNotifications(),
                            );
                        Navigator.pop(context);
                      },
                    ),
                    icon: const Icon(
                      Icons.delete,
                    ),
                  )
                else
                  IconButton(
                    onPressed: notifications.isNotEmpty
                        ? () => navigateToNotificationScreen(context)
                        : null,
                    icon: const Icon(
                      Icons.notifications,
                      size: appBarIconSize,
                    ),
                  ),
                if (totalAmountOfNotifications > 0)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      height: notificationContainerHeight,
                      width: notificationContainerWidth,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: notificationColor,
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            totalAmountOfNotifications.toString(),
                            style: boldTextStyle,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox(),
              ],
            ),
          );
        } else if (state is NotificationStateErrorState) {
          return IconButton(
            onPressed: () => context
                .read<NotificationBloc>()
                .add(const NotificationEventInitializeNotifications()),
            icon: const Icon(
              Icons.refresh,
              size: appBarIconSize,
            ),
          );
        }
        {
          return const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications,
              size: appBarIconSize,
            ),
          );
        }
      },
    );
  }
}
