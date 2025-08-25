import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/dashboard_repo.dart';
import '../../../data/models/section_ratings_model.dart';
import 'section_ratings_state.dart';

class SectionRatingsCubit extends Cubit<SectionRatingsState> {
  final DashboardRepo _repo;
  SectionRatingsCubit(this._repo) : super(SectionRatingsInitial());

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
    emit(SectionRatingsLoading());
    try {
      final res = await _repo.fetchSectionRatings(
        startDate: start != null ? _fmt(start) : null,
        endDate:   end   != null ? _fmt(end)   : null,
        limit:     limit,
        order:     order,
      );
      // already sorted by API using order param
      emit(SectionRatingsSuccess(
        items: res.data,
        startDate: start != null ? _fmt(start) : null,
        endDate: end != null ? _fmt(end) : null,
        limit: limit,
        order: order,
      ));
    } catch (e) {
      emit(SectionRatingsFailure(e.toString()));
    }
  }
}
