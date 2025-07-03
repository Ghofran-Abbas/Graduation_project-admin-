// lib/features/points/presentation/manager/update_points_cubit/update_points_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/points_repo.dart';
import 'update_points_state.dart';

class UpdatePointsCubit extends Cubit<UpdatePointsState> {
  final PointsRepo _repo;
  UpdatePointsCubit(this._repo) : super(UpdatePointsInitial());

  Future<void> updatePoints(int studentId, int points) async {
    emit(UpdatePointsLoading());
    try {
      final updated = await _repo.updatePoints(
        studentId: studentId,
        points: points,
      );
      emit(UpdatePointsSuccess(updated));
    } catch (e) {
      emit(UpdatePointsFailure(e.toString()));
    }
  }
}
