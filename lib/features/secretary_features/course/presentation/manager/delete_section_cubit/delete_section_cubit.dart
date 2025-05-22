import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'delete_section_state.dart';

class DeleteSectionCubit extends Cubit<DeleteSectionState>{
  static DeleteSectionCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  DeleteSectionCubit(this.courseRepo) : super(DeleteSectionInitial());

  Future<void> fetchDeleteSection({required int id}) async {
    emit(DeleteSectionLoading());
    var result = await courseRepo.fetchDeleteSection(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteSectionFailure(failure.errorMessage));
    }, (deleteResult) {
      emit(DeleteSectionSuccess(deleteResult));
    });
  }
}