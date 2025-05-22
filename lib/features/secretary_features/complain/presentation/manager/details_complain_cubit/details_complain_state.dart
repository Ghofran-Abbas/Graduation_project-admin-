import 'package:equatable/equatable.dart';

import '../../../data/models/details_complain_model.dart';

abstract class DetailsComplainState extends Equatable {
  const DetailsComplainState();

  @override
  List<Object?> get props => [];
}

class DetailsComplainInitial extends DetailsComplainState {}
class DetailsComplainLoading extends DetailsComplainState {}
class DetailsComplainFailure extends DetailsComplainState {
  final String errorMessage;

  const DetailsComplainFailure(this.errorMessage);
}
class DetailsComplainSuccess extends DetailsComplainState {
  final DetailsComplainModel complain;

  const DetailsComplainSuccess(this.complain);
}