import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/points_repo.dart';
import 'update_secretary_points_state.dart';

class UpdateSecretaryPointsCubit extends Cubit<UpdateSecretaryPointsState> {
  final PointsRepo _repo;
  UpdateSecretaryPointsCubit(this._repo) : super(UpdateSecretaryPointsInitial());

  Future<void> updatePoints(int secretaryId, int points) async {
    emit(UpdateSecretaryPointsLoading());
    try {
      final updated = await _repo.updateSecretaryPoints(
        secretaryId: secretaryId,
        points: points,
      );
      emit(UpdateSecretaryPointsSuccess(updated));
    } catch (e) {
      emit(UpdateSecretaryPointsFailure(e.toString()));
    }
  }
}
