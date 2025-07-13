import 'package:equatable/equatable.dart';
import '../../../data/models/register_secretary_model.dart';

abstract class RegisterSecretaryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSecretaryInitial extends RegisterSecretaryState {}
class RegisterSecretaryLoading extends RegisterSecretaryState {}

class RegisterSecretarySuccess extends RegisterSecretaryState {
  final RegisterSecretaryModel result;
  RegisterSecretarySuccess(this.result);
  @override
  List<Object?> get props => [result];
}

class RegisterSecretaryFailure extends RegisterSecretaryState {
  final String error;
  RegisterSecretaryFailure(this.error);
  @override
  List<Object?> get props => [error];
}