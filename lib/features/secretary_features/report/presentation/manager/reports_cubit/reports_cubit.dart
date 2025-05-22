import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState>{
  static ReportsCubit get(context) => BlocProvider.of(context);

  final ReportRepo reportRepo;

  ReportsCubit(this.reportRepo) : super(ReportsInitial());

  Future<void> fetchReports({required int page}) async {
    emit(ReportsLoading());
    var result = await reportRepo.fetchReports(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ReportsFailure(failure.errorMessage));
    }, (reports) {
      emit(ReportsSuccess(reports));
    });
  }
}