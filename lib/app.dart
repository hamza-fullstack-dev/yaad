import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routing/app_router.dart';
import 'core/routing/route_names.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';

class YaadApp extends ConsumerStatefulWidget {
  const YaadApp({super.key});

  @override
  ConsumerState<YaadApp> createState() => _YaadAppState();
}

class _YaadAppState extends ConsumerState<YaadApp> {
  @override
  void initState() {
    super.initState();
    NotificationService.onAlarmTap = _handleAlarmTap;
  }

  void _handleAlarmTap(String taskTitle, int notificationId) {
    final router = ref.read(appRouterProvider);
    router.push(RouteNames.alarm, extra: {
      'taskTitle': taskTitle,
      'notificationId': notificationId,
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Yaad',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
