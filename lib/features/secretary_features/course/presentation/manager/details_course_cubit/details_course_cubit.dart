import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'details_course_state.dart';

class DetailsCourseCubit extends Cubit<DetailsCourseState>{
  static DetailsCourseState get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  DetailsCourseCubit(this.courseRepo) : super(DetailsCourseInitial());

  Future<void> fetchDetailsCourse({required int id}) async {
    emit(DetailsCourseLoading());
    var result = await courseRepo.fetchDetailsCourse(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsCourseFailure(failure.errorMessage));
    }, (course) {
      emit(DetailsCourseSuccess(course));
    });
  }
}