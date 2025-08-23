// lib/features/notifications/presentation/manager/notifications_cubit.dart
//
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../data/repos/notification_repo.dart';
import 'notification_state.dart';
//
//
// class NotificationsCubit extends Cubit<NotificationsState> {
//   final NotificationsRepository _repo;
//   NotificationsCubit(this._repo) : super(NotificationsInitial());
//
//   Future<void> fetchNotifications() async {
//     try {
//       emit(NotificationsLoading());
//       final list = await _repo.fetchNotifications();
//       emit(NotificationsLoaded(list));
//     } on DioError catch (e) {
//       final msg = (e.response?.data['message'] as String?) ?? 'Network error';
//       emit(NotificationsError(msg));
//     } catch (e) {
//       emit(NotificationsError(e.toString()));
//     }
//   }
// }









import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

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
      final status = e.response?.statusCode;
      final msg = (status == 401)
          ? 'Unauthorized: يرجى تسجيل الدخول من جديد'
          : (e.response?.data is Map && (e.response?.data['message'] is String)
          ? e.response?.data['message'] as String
          : 'Network error');
      emit(NotificationsError(msg));
    } catch (e) {
      // لو التوكن غير موجود مثل ما رميناه في الريبو
      final msg = e.toString().contains('No JWT token') ? 'Unauthorized: مفقود التوكن' : e.toString();
      emit(NotificationsError(msg));
    }
  }
}
