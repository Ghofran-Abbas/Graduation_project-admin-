import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/top_courses_model.dart';
import '../../../data/repos/dashboard_repo.dart';
import 'top_courses_state.dart';

class TopCoursesCubit extends Cubit<TopCoursesState> {
  final DashboardRepo _repo;

  TopCoursesCubit(this._repo) : super(TopCoursesInitial());

  Future<void> load() async {
    emit(TopCoursesLoading());
    try {
      final res = await _repo.fetchTopCourses();
      emit(TopCoursesSuccess(items: res.data, message: res.message));
    } catch (e) {
      emit(TopCoursesFailure(e.toString()));
    }
  }
}
