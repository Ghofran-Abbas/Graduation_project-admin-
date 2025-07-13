import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/points_repo.dart';
import 'top_secretaries_state.dart';

class TopSecretariesCubit extends Cubit<TopSecretariesState> {
  final PointsRepo _repo;
  TopSecretariesCubit(this._repo) : super(TopSecretariesInitial());

  Future<void> fetchTopSecretaries({int limit = 10}) async {
    emit(TopSecretariesLoading());
    try {
      final list = await _repo.fetchTopSecretaries(limit: limit);
      emit(TopSecretariesSuccess(list));
    } catch (e) {
      emit(TopSecretariesFailure(e.toString()));
    }
  }
}
