import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/create_course_model.dart';

abstract class CreateCourseState extends Equatable{
  const CreateCourseState();

  @override
  List<Object?> get props => [];
}

class CreateCourseInitial extends CreateCourseState{}
class CreateCourseLoading extends CreateCourseState{}
class CreateCourseFailure extends CreateCourseState{
  final String errorMessage;

  const CreateCourseFailure(this.errorMessage);
}
class CreateCourseSuccess extends CreateCourseState{
  final CreateCourseModel createResult;

  const CreateCourseSuccess(this.createResult);
}

class ImagePickedSuccess extends CreateCourseState{
  final FilePickerResult image;

  const ImagePickedSuccess(this.image);
}