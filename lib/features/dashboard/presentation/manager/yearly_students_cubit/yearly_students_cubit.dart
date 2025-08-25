import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/dashboard_repo.dart';
import '../../../data/models/students_stats_model.dart';
import 'yearly_students_state.dart';

class YearlyStudentsCubit extends Cubit<YearlyStudentsState> {
  final DashboardRepo _repo;
  YearlyStudentsCubit(this._repo) : super(YearlyStudentsInitial());

  Future<void> load() async {
    emit(YearlyStudentsLoading());
    try {
      final res = await _repo.fetchYearlyStudents();
      // Sort ascending by year for nicer axis
      final items = [...res.data]..sort((a, b) => a.year.compareTo(b.year));
      emit(YearlyStudentsSuccess(items));
    } catch (e) {
      emit(YearlyStudentsFailure(e.toString()));
    }
  }
}
