import 'package:equatable/equatable.dart';

import '../../../data/models/reports_model.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => [];
}

class ReportsInitial extends ReportsState {}
class ReportsLoading extends ReportsState {}
class ReportsFailure extends ReportsState {
  final String errorMessage;

  const ReportsFailure(this.errorMessage);
}
class ReportsSuccess extends ReportsState {
  final ReportsModel reports;

  const ReportsSuccess(this.reports);
}