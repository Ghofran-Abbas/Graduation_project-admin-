import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/student_repo.dart';
import 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {

  static StudentsCubit get(context) => BlocProvider.of(context);

  StudentsCubit(this.studentRepo,) : super(StudentsInitial());

  final StudentRepo studentRepo;

  Future<void> fetchStudents({required int page}) async {
    emit(StudentsLoading());
    var result = await studentRepo.fetchStudents(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(StudentsFailure(failure.errorMessage));
    }, (students) {
      emit(StudentsSuccess(students));
    },
    );
  }
}