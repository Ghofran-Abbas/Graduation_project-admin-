// lib/features/gifts/presentation/views/student_gifts_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_alhadara_dashboard/core/utils/service_locator.dart';
import 'package:admin_alhadara_dashboard/features/gifts/data/repos/gift_repo_impl.dart';
import 'package:admin_alhadara_dashboard/features/gifts/presentation/manager/create_gift_cubit/create_gift_cubit.dart';
import 'package:admin_alhadara_dashboard/features/gifts/presentation/manager/delete_gift_cubit/delete_gift_cubit.dart';
import 'package:admin_alhadara_dashboard/features/gifts/presentation/manager/update_gift_cubit/update_gift_cubit.dart';
import 'package:admin_alhadara_dashboard/features/gifts/presentation/manager/gifts_cubit/gifts_cubit.dart';

import 'widgets/gifts_view_body.dart';

/// Shows *only* the awards belonging to a given student.
class StudentGiftsView extends StatelessWidget {
  final int studentId;
  const StudentGiftsView({Key? key, required this.studentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 1️⃣ Load page 1 filtered by student:
        BlocProvider(
          create: (_) => GiftsCubit(getIt.get<GiftRepoImpl>())
            ..fetchForStudent(studentId, page: 1),
        ),
        // 2️⃣ Dialog cubits: create / update / delete
        BlocProvider(create: (_) => CreateGiftCubit(getIt.get<GiftRepoImpl>())),
        BlocProvider(create: (_) => UpdateGiftCubit(getIt.get<GiftRepoImpl>())),
        BlocProvider(create: (_) => DeleteGiftCubit(getIt.get<GiftRepoImpl>())),
      ],
      child: GiftsViewBody(studentId: studentId),
    );
  }
}
