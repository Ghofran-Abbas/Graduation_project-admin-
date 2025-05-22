import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/student_repo.dart';
import 'create_student_state.dart';

class CreateStudentCubit extends Cubit<CreateStudentState> {

  static CreateStudentCubit get(context) => BlocProvider.of(context);

  CreateStudentCubit(this.studentRepo,) : super(CreateStudentInitial());

  final StudentRepo studentRepo;

  /*IconData suffixIcon = Icons.visibility_off;
  bool isPassShow = true;

  void changePassVisibility() {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(ChangePassVisibilityState());
  }*/

  Future<void> fetchCreateStudent({
    required String name,
    required String email,
    required String phone,
    required String password,
    required Uint8List photo,
    required String birthday,
  }) async {
    emit(CreateStudentLoading());
    var result = await studentRepo.fetchCreateStudent(
      name: name,
      email: email,
      password: password,
      phone: phone,
      photo: photo,
      birthday: birthday,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateStudentFailure(failure.errorMessage));
    }, (createStudent) {
      emit(CreateStudentSuccess(createStudent));
    },
    );
  }
}