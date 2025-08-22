// lib/features/notifications/presentation/manager/notifications_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../data/repos/notification_repo.dart';
import 'notification_state.dart';


class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repo;
  NotificationsCubit(this._repo) : super(NotificationsInitial());

  Future<void> fetchNotifications() async {
    try {
      emit(NotificationsLoading());
      final list = await _repo.fetchNotifications();
      emit(NotificationsLoaded(list));
    } on DioError catch (e) {
      final msg = (e.response?.data['message'] as String?) ?? 'Network error';
      emit(NotificationsError(msg));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }
}
