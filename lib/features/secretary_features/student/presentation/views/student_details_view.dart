import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/student_repo_impl.dart';
import '../manager/details_student_cubit/details_student_cubit.dart';
import 'widgets/student_details_view_body.dart';

class StudentDetailsView extends StatefulWidget {
  const StudentDetailsView({super.key, required this.id});

  final int id;

  @override
  State<StudentDetailsView> createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<StudentDetailsView> {
  late final DetailsStudentCubit _cubit;
  late int _currentId;

  @override
  void initState() {
    super.initState();
    _cubit = DetailsStudentCubit(getIt.get<StudentRepoImpl>());
    _currentId = widget.id;
    _cubit.fetchDetailsStudent(id: _currentId);
  }

  @override
  void didUpdateWidget(covariant StudentDetailsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _currentId = widget.id;
      _cubit.fetchDetailsStudent(id: _currentId);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: StudentDetailsViewBody(),
    );
  }
}
