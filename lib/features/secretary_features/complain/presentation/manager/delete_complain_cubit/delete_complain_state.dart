import 'package:equatable/equatable.dart';

import '../../../data/models/delete_complain_model.dart';

abstract class DeleteComplainState extends Equatable{
  const DeleteComplainState();

  @override
  List<Object> get props => [];
}

class DeleteComplainInitial extends DeleteComplainState{}
class DeleteComplainLoading extends DeleteComplainState{}
class DeleteComplainFailure extends DeleteComplainState{
  final String errorMessage;

  const DeleteComplainFailure(this.errorMessage);
}
class DeleteComplainSuccess extends DeleteComplainState{
  final DeleteComplainModel deleteResult;

  const DeleteComplainSuccess(this.deleteResult);
}