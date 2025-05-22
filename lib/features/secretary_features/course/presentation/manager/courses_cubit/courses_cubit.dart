import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState>{

  static CoursesCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  CoursesCubit(this.courseRepo) : super(CoursesInitial());

  Future<void> fetchCourses({required int page}) async {
    emit(CoursesLoading());
    var result = await courseRepo.fetchCourses(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CoursesFailure(failure.errorMessage));
    }, (courses) {
      emit(CoursesSuccess(courses));
    });
  }
}