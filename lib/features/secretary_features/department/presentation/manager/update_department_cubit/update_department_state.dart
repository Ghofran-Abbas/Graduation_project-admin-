import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/update_department_model.dart';

abstract class UpdateDepartmentState extends Equatable{
  const UpdateDepartmentState();

  @override
  List<Object?> get props => [];
}

class UpdateDepartmentInitial extends UpdateDepartmentState{}
class UpdateDepartmentLoading extends UpdateDepartmentState{}
class UpdateDepartmentFailure extends UpdateDepartmentState{
  final String errorMessage;

  const UpdateDepartmentFailure(this.errorMessage);
}
class UpdateDepartmentSuccess extends UpdateDepartmentState{
  final UpdateDepartmentModel updateResult;

  const UpdateDepartmentSuccess(this.updateResult);
}

class ImagePickedSuccess extends UpdateDepartmentState{
  final FilePickerResult image;

  const ImagePickedSuccess(this.image);
}