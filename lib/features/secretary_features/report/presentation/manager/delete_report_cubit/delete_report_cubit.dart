import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'delete_report_state.dart';

class DeleteReportCubit extends Cubit<DeleteReportState>{
  static DeleteReportState get(context) => BlocProvider.of(context);

  DeleteReportCubit(this.reportRepo,) : super(DeleteReportInitial());

  final ReportRepo reportRepo;

  Future<void> fetchDeleteReport({
    required int id,
  }) async {
    emit(DeleteReportLoading());
    var result = await reportRepo.fetchDeleteReport(
      id: id,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteReportFailure(failure.errorMessage));
    }, (updateResult) {
      emit(DeleteReportSuccess(updateResult));
    });
  }
}