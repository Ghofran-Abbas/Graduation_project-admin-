import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'update_course_state.dart';

class UpdateCourseCubit extends Cubit<UpdateCourseState>{
  static UpdateCourseState get(context) => BlocProvider.of(context);

  UpdateCourseCubit(this.courseRepo,) : super(UpdateCourseInitial());

  final CourseRepo courseRepo;

  Future<void> fetchUpdateCourse({
    required int id,
    required int departmentId,
    String? name,
    String? description,
    Uint8List? photo,
  }) async {
    emit(UpdateCourseLoading());
    var result = await courseRepo.fetchUpdateCourse(
      id: id,
      departmentId: departmentId,
      name: name,
      description: description,
      photo: photo,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateCourseFailure(failure.errorMessage));
    }, (updateResult) {
      emit(UpdateCourseSuccess(updateResult));
    });
  }
}