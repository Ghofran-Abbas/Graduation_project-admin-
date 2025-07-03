import '../../../data/models/secretary_point_model.dart';

abstract class UpdateSecretaryPointsState {}

class UpdateSecretaryPointsInitial extends UpdateSecretaryPointsState {}
class UpdateSecretaryPointsLoading extends UpdateSecretaryPointsState {}
class UpdateSecretaryPointsSuccess extends UpdateSecretaryPointsState {
  final SecretaryPoint updated;
  UpdateSecretaryPointsSuccess(this.updated);
}
class UpdateSecretaryPointsFailure extends UpdateSecretaryPointsState {
  final String error;
  UpdateSecretaryPointsFailure(this.error);
}
