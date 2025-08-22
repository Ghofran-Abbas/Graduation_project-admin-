// lib/features/notifications/presentation/views/notifications_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../data/models/notification_model.dart';
import '../manager/notification_cubit.dart';
import '../manager/notification_state.dart';


class NotificationsBody extends StatelessWidget {
  const NotificationsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsLoading) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        if (state is NotificationsError) {
          return Center(child: CustomErrorWidget(errorMessage: state.message));
        }
        if (state is NotificationsLoaded) {
          final List<NotificationModel> items = state.notifications;
          if (items.isEmpty) {
            return Center(child: Text('No notifications'));
          }

          return RefreshIndicator(
            onRefresh: () => context.read<NotificationsCubit>().fetchNotifications(),
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final n = items[index];
                return _NotificationTile(notification: n);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  const _NotificationTile({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('yyyy-MM-dd HH:mm');
    return ListTile(
      onTap: () {
        // هنا ممكن تفتح صفحة تفاصيل أو تعلِم الإشعار كمقروء عبر Cubit آخر
        // مثال: Navigator.pushNamed(context, '/notification/${notification.id}');
      },
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 22,
            child: Icon(Icons.notifications),
          ),
          if (!notification.isRead)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            ),
        ],
      ),
      title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(notification.body),
          const SizedBox(height: 6),
          Text(fmt.format(notification.createdAt), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
      isThreeLine: true,
    );
  }
}
