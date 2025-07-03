// lib/features/points/presentation/manager/top_students_cubit/top_students_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/points_repo.dart';
import 'top_students_state.dart';

class TopStudentsCubit extends Cubit<TopStudentsState> {
  final PointsRepo _repo;
  TopStudentsCubit(this._repo) : super(TopStudentsInitial());

  Future<void> fetchTopStudents({int limit = 10}) async {
    emit(TopStudentsLoading());
    try {
      final list = await _repo.fetchTopStudents(limit: limit);
      emit(TopStudentsSuccess(list));
    } catch (e) {
      emit(TopStudentsFailure(e.toString()));
    }
  }
}
