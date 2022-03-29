import 'package:camicie_mockup/core/fabric/models/fabric.dart';
import 'package:camicie_mockup/core/notification/models/notification.dart';
import 'package:camicie_mockup/core/stats/models/stat.dart';
import 'package:camicie_mockup/ui/fabric/bloc/fabric_bloc.dart';
import 'package:camicie_mockup/ui/notification/bloc/notification_bloc.dart';
import 'package:camicie_mockup/ui/statistics_screen/bloc/statistics_bloc.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:camicie_mockup/utils/widgets/dialog/custom_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

Future<void> showQuantityPickerDialog(
  BuildContext context, {
  Fabric? fabric,
  MissingModelNotification? notification,
  required String title,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext ctx) => QuantityPicker(
      context: context,
      fabric: fabric,
      notification: notification,
      title: title,
    ),
  );
}

class QuantityPicker extends StatefulWidget {
  const QuantityPicker({
    required this.context,
    required this.fabric,
    required this.notification,
    required this.title,
    Key? key,
  }) : super(key: key);
  final BuildContext context;

  final Fabric? fabric;
  final MissingModelNotification? notification;
  final String title;

  @override
  State<QuantityPicker> createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  late Fabric? fabric;
  late MissingModelNotification? notification;

  @override
  void initState() {
    fabric = widget.fabric;
    notification = widget.notification;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: NumberPicker(
        minValue: minQuantity,
        maxValue: maxQuantity,
        value: fabric?.totalAmount ?? notification!.totalAmount,
        onChanged: (int value) => setState(() {
          fabric = fabric?.copyWith(totalAmount: value);
          notification = notification?.copyWith(totalAmount: value);
        }),
      ),
      actions: <ElevatedButton>[
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            cancelLabel,
            style: boldTextStyle.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showCustomLoaderDialog(context);
            final NotificationBloc notificationBloc =
                widget.context.read<NotificationBloc>();
            final StatisticsBloc statisticsBloc =
                widget.context.read<StatisticsBloc>();
            final NotificationState notificationState = notificationBloc.state;
            final StatisticsState statisticsState = statisticsBloc.state;
            if (fabric != null &&
                fabric!.totalAmount < widget.fabric!.totalAmount) {
              final int totalAmount =
                  widget.fabric!.totalAmount - fabric!.totalAmount;
              if (notificationState is NotificationLoadedState) {
                MissingModelNotification? notification;
                for (final MissingModelNotification item
                    in notificationState.notifications) {
                  if (item.fabricId == fabric!.id) {
                    notification = item.copyWith(
                      totalAmount: item.totalAmount + totalAmount,
                    );
                  }
                }
                if (notification != null) {
                  notificationBloc
                      .add(NotificationEventUpdateNotification(notification));
                  if (statisticsState is StatisticsLoadedState) {
                    final List<Stat> stats = statisticsState.stats;
                    if (stats.any(
                      (Stat element) => element.fabricId == fabric!.id,
                    )) {
                      final Stat stat = stats.firstWhere(
                        (Stat element) => element.fabricId == fabric!.id,
                      );
                      final Map<DateTime, int> buyDatesAndQuantity =
                          stat.buyDatesAndQuantity;
                      buyDatesAndQuantity.putIfAbsent(
                        DateTime.now(),
                        () => totalAmount,
                      );
                      statisticsBloc.add(
                        StatisticsEventUpdateStatEvent(
                          stat.copyWith(
                            buyDatesAndQuantity: buyDatesAndQuantity,
                          ),
                        ),
                      );
                    } else {
                      final Map<DateTime, int> buyDateAndTotalAmount =
                          <DateTime, int>{};
                      buyDateAndTotalAmount.putIfAbsent(
                        DateTime.now(),
                        () => totalAmount,
                      );
                      final Stat stat = Stat(
                        '',
                        fabric!.id,
                        buyDateAndTotalAmount,
                      );
                      statisticsBloc.add(StatisticsEventAddStatEvent(stat));
                    }
                  }
                } else {
                  notification = MissingModelNotification(
                    '',
                    fabric!.imageUrl,
                    fabric!.fabricName,
                    fabric!.id,
                    fabric!.size,
                    totalAmount,
                  );
                  notificationBloc
                      .add(NotificationEventAddNotification(notification));
                  if (statisticsState is StatisticsLoadedState) {
                    final List<Stat> stats = statisticsState.stats;
                    if (stats.any(
                      (Stat element) => element.fabricId == fabric!.id,
                    )) {
                      final Stat stat = stats.firstWhere(
                        (Stat element) => element.fabricId == fabric!.id,
                      );
                      final Map<DateTime, int> buyDatesAndQuantity =
                          stat.buyDatesAndQuantity;
                      buyDatesAndQuantity.putIfAbsent(
                        DateTime.now(),
                        () => totalAmount,
                      );
                      statisticsBloc.add(
                        StatisticsEventUpdateStatEvent(
                          stat.copyWith(
                            buyDatesAndQuantity: buyDatesAndQuantity,
                          ),
                        ),
                      );
                    } else {
                      final Map<DateTime, int> buyDateAndTotalAmount =
                          <DateTime, int>{};
                      buyDateAndTotalAmount.putIfAbsent(
                        DateTime.now(),
                        () => totalAmount,
                      );
                      final Stat stat = Stat(
                        '',
                        fabric!.id,
                        buyDateAndTotalAmount,
                      );
                      statisticsBloc.add(StatisticsEventAddStatEvent(stat));
                    }
                  }
                }
                widget.context
                    .read<FabricBloc>()
                    .add(FabricEventUpdateFabric(fabric!));
              }
            } else if (fabric != null) {
              widget.context
                  .read<FabricBloc>()
                  .add(FabricEventUpdateFabric(fabric!));
            } else if (notification != null) {
              notificationBloc
                  .add(NotificationEventUpdateNotification(notification!));
            }
            Navigator.pop(context);
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Text(
            confirmLabel,
            style: boldTextStyle.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
