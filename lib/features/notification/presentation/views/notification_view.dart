// lib/features/notifications/presentation/views/notifications_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../manager/notification_cubit.dart';
import 'notification_body.dart'; // getIt

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create cubit and fetch notifications immediately
    return BlocProvider<NotificationsCubit>(
      create: (_) {
        final cubit = getIt<NotificationsCubit>();
        cubit.fetchNotifications();
        return cubit;
      },
      child: const NotificationsBody(),
    );
  }
}
