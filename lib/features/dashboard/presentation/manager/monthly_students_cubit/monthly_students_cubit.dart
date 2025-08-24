import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/dashboard_repo.dart';
import '../../../data/models/students_stats_model.dart';
import 'monthly_students_state.dart';

class MonthlyStudentsCubit extends Cubit<MonthlyStudentsState> {
  final DashboardRepo _repo;
  MonthlyStudentsCubit(this._repo) : super(MonthlyStudentsInitial());

  Future<void> load({required int year}) async {
    emit(MonthlyStudentsLoading());
    try {
      final res = await _repo.fetchMonthlyStudents(year: year);

      // Fill 1..12 months with zeros if missing
      final map = {for (final m in res.data) m.month: m};
      final filled = <MonthlyStudentStat>[];
      for (int m = 1; m <= 12; m++) {
        if (map.containsKey(m)) {
          filled.add(map[m]!);
        } else {
          filled.add(MonthlyStudentStat(month: m, totalStudents: 0, monthName: null));
        }
      }

      final total = filled.fold<int>(0, (s, e) => s + e.totalStudents);
      emit(MonthlyStudentsSuccess(year: year, items: filled, total: total));
    } catch (e) {
      emit(MonthlyStudentsFailure(e.toString()));
    }
  }
}
