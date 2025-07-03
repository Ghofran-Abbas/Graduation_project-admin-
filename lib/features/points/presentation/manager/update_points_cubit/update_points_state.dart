// lib/features/points/presentation/manager/update_points_cubit/update_points_state.dart

import '../../../data/models/student_point_model.dart';

abstract class UpdatePointsState {}
class UpdatePointsInitial extends UpdatePointsState {}
class UpdatePointsLoading extends UpdatePointsState {}
class UpdatePointsSuccess extends UpdatePointsState {
  final StudentPoint updated;
  UpdatePointsSuccess(this.updated);
}
class UpdatePointsFailure extends UpdatePointsState {
  final String error;
  UpdatePointsFailure(this.error);
}
