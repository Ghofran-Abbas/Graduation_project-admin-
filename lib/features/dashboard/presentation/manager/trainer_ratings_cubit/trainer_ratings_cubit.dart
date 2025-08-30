import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/dashboard_repo.dart';
import 'trainer_ratings_state.dart';

class TrainerRatingsCubit extends Cubit<TrainerRatingsState> {
  final DashboardRepo _repo;
  TrainerRatingsCubit(this._repo) : super(TrainerRatingsInitial());

  String _fmt(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }

  Future<void> load({
    DateTime? start,
    DateTime? end,
    int? limit = 5,
    String order = 'desc',
  }) async {
    emit(TrainerRatingsLoading());
    try {
      final res = await _repo.fetchTrainerRatings(
        startDate: start != null ? _fmt(start) : null,
        endDate:   end   != null ? _fmt(end)   : null,
        limit:     limit,
        order:     order,
      );
      emit(TrainerRatingsSuccess(
        items: res.data,
        startDate: start != null ? _fmt(start) : null,
        endDate: end != null ? _fmt(end) : null,
        limit: limit,
        order: order,
      ));
    } catch (e) {
      emit(TrainerRatingsFailure(e.toString()));
    }
  }
}
