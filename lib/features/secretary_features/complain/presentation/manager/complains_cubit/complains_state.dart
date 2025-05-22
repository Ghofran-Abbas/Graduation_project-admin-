import 'package:equatable/equatable.dart';

import '../../../data/models/complains_model.dart';

abstract class ComplainsState extends Equatable {
  const ComplainsState();

  @override
  List<Object?> get props => [];
}

class ComplainsInitial extends ComplainsState {}
class ComplainsLoading extends ComplainsState {}
class ComplainsFailure extends ComplainsState {
  final String errorMessage;

  const ComplainsFailure(this.errorMessage);
}
class ComplainsSuccess extends ComplainsState {
  final ComplainsModel complains;

  const ComplainsSuccess(this.complains);
}