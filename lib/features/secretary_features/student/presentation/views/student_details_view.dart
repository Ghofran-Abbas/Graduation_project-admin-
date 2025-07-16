// lib/features/points/presentation/views/student_details_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../points/data/repos/points_repo_impl.dart';
import '../../../../points/presentation/manager/update_points_cubit/update_points_cubit.dart';
import '../../data/repos/student_repo_impl.dart';
import '../manager/archive_section_student_cubit/archive_section_student_cubit.dart';
import '../manager/details_student_cubit/details_student_cubit.dart';
import 'widgets/student_details_view_body.dart';

class StudentDetailsView extends StatefulWidget {
  const StudentDetailsView({super.key, required this.id});

  final int id;

  @override
  State<StudentDetailsView> createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<StudentDetailsView> {
  late final DetailsStudentCubit _detailsCubit;
  late final UpdatePointsCubit   _updateCubit;
  late final ArchiveStudentCubit _archiveCubit;
  late int _currentId;

  @override
  void initState() {
    super.initState();
    _detailsCubit = DetailsStudentCubit(getIt.get<StudentRepoImpl>());
    _updateCubit  = UpdatePointsCubit(getIt.get<PointsRepoImpl>());
    _archiveCubit = ArchiveStudentCubit(getIt.get<StudentRepoImpl>());
    _currentId    = widget.id;
    _detailsCubit.fetchDetailsStudent(id: _currentId);
    _archiveCubit.fetchArchiveStudent(id: _currentId, page: 1);
  }

  @override
  void didUpdateWidget(covariant StudentDetailsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _currentId = widget.id;
      _detailsCubit.fetchDetailsStudent(id: _currentId);
      _archiveCubit.fetchArchiveStudent(id: _currentId, page: 1);
    }
  }

  @override
  void dispose() {
    _detailsCubit.close();
    _updateCubit.close();
    _archiveCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _detailsCubit),
        BlocProvider.value(value: _updateCubit),
        BlocProvider.value(
          value: _archiveCubit,
        ),
      ],
      child:  StudentDetailsViewBody(studentId: widget.id,),
    );
  }
}
