import '../../../data/models/secretary_point_model.dart';

abstract class TopSecretariesState {}

class TopSecretariesInitial extends TopSecretariesState {}
class TopSecretariesLoading extends TopSecretariesState {}
class TopSecretariesSuccess extends TopSecretariesState {
  final List<SecretaryPoint> secretaries;
  TopSecretariesSuccess(this.secretaries);
}
class TopSecretariesFailure extends TopSecretariesState {
  final String error;
  TopSecretariesFailure(this.error);
}
