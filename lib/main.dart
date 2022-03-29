import 'package:camicie_mockup/core/fabric/fabric_repository.dart';
import 'package:camicie_mockup/core/model_of_shirt/model_of_shirt_repository.dart';
import 'package:camicie_mockup/core/notification/notification_repository.dart';
import 'package:camicie_mockup/core/settings/global_settings_repository.dart';
import 'package:camicie_mockup/core/shared/shared_preferences/shared_preferences.dart';
import 'package:camicie_mockup/core/size_model/size_repository.dart';
import 'package:camicie_mockup/core/stats/stats_repository.dart';
import 'package:camicie_mockup/ui/main/main_container.dart';
import 'package:camicie_mockup/ui/main/main_navigation/bloc/main_navigation_bloc.dart';
import 'package:camicie_mockup/ui/model_detail_screen/bloc/model_bloc.dart';
import 'package:camicie_mockup/ui/notification/bloc/notification_bloc.dart';
import 'package:camicie_mockup/ui/settings/bloc/settings_bloc.dart';
import 'package:camicie_mockup/ui/statistics_screen/bloc/statistics_bloc.dart';
import 'package:camicie_mockup/utils/colors.dart';
import 'package:camicie_mockup/utils/theme.dart';
import 'package:camicie_mockup/utils/widgets/dialog/full_screen_loader.dart';
import 'package:camicie_mockup/utils/widgets/widget/error_and_retry.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CamicieMockup());
}

class CamicieMockup extends StatelessWidget {
  const CamicieMockup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _getRepositoryProviders(),
      child: MultiBlocProvider(
        providers: _getBlocProviders(),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (BuildContext context, SettingsState state) {
            if (state is SettingsLoadedState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: const MainContainer(),
                theme: themeData,
                darkTheme: darkThemeData,
                themeMode: state.themeMode,
              );
            } else if (state is SettingsErrorState) {
              return Material(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    color: primaryDarkColor,
                    child: ErrorAndRetry(
                      retryFunction: () {
                        context.read<SettingsBloc>().add(
                              const SettingsEventInitializeSettings(),
                            );
                        context.read<NotificationBloc>().add(
                              const NotificationEventInitializeNotifications(),
                            );
                        context.read<ModelBloc>().add(
                              const ModelEventInitialEvent(),
                            );
                      },
                      color: primaryLightColor,
                    ),
                  ),
                ),
              );
            } else {
              return const FullScreenLoader();
            }
          },
        ),
      ),
    );
  }

  List<RepositoryProvider<dynamic>> _getRepositoryProviders() =>
      <RepositoryProvider<dynamic>>[
        RepositoryProvider<NotificationRepository>(
          create: (BuildContext context) => NotificationRepository(),
          lazy: false,
        ),
        RepositoryProvider<GlobalSettingsRepository>(
          create: (BuildContext context) => GlobalSettingsRepository(),
          lazy: false,
        ),
        RepositoryProvider<SharedPref>(
          create: (BuildContext context) => SharedPref(),
          lazy: false,
        ),
        RepositoryProvider<ModelOfShirtRepository>(
          create: (BuildContext context) => ModelOfShirtRepository(),
          lazy: false,
        ),
        RepositoryProvider<SizeModelRepository>(
          create: (BuildContext context) => SizeModelRepository(),
        ),
        RepositoryProvider<FabricRepository>(
          create: (BuildContext context) => FabricRepository(),
        ),
        RepositoryProvider<StatsRepository>(
          create: (BuildContext context) => StatsRepository(),
        ),
      ];

  List<BlocProvider<dynamic>> _getBlocProviders() => <BlocProvider<dynamic>>[
        BlocProvider<SettingsBloc>(
          create: (BuildContext context) => SettingsBloc(context),
          lazy: false,
        ),
        BlocProvider<NotificationBloc>(
          create: (BuildContext context) => NotificationBloc(context),
          lazy: false,
        ),
        BlocProvider<MainNavigationBloc>(
          create: (BuildContext context) => MainNavigationBloc(),
          lazy: false,
        ),
        BlocProvider<ModelBloc>(
          create: (BuildContext context) => ModelBloc(context),
          lazy: false,
        ),
        BlocProvider<StatisticsBloc>(
          create: (BuildContext context) => StatisticsBloc(context),
          lazy: false,
        ),
      ];
}
