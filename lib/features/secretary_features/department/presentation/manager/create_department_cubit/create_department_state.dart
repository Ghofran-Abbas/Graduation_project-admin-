import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/create_department_model.dart';

abstract class CreateDepartmentState extends Equatable{
  const CreateDepartmentState();

  @override
  List<Object?> get props => [];
}

class CreateDepartmentInitial extends CreateDepartmentState{}
class CreateDepartmentLoading extends CreateDepartmentState{}
class CreateDepartmentFailure extends CreateDepartmentState{
  final String errorMessage;

  const CreateDepartmentFailure(this.errorMessage);
}
class CreateDepartmentSuccess extends CreateDepartmentState{
  final CreateDepartmentModel createResult;

  const CreateDepartmentSuccess(this.createResult);
}

class ImagePickedSuccess extends CreateDepartmentState{
  final FilePickerResult image;

  const ImagePickedSuccess(this.image);
}