import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/data/repos/login_secretary_repo_impl.dart';
import '../../features/secretary_features/complain/data/repos/complain_repo_impl.dart';
import '../../features/secretary_features/course/data/repos/course_repo_impl.dart';
import '../../features/secretary_features/department/data/repos/department_repo_impl.dart';
import '../../features/secretary_features/forgot_password/data/repos/forgot_password_repo_impl.dart';
import '../../features/secretary_features/logout/data/repos/logout_secretary_impl.dart';
import '../../features/secretary_features/report/data/repos/report_repo_impl.dart';
import '../../features/secretary_features/student/data/repos/student_repo_impl.dart';
import '../../features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import '../../features/secretary_features/verification/data/repos/verification_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {

  getIt.registerSingleton<DioApiService>(
    DioApiService(
        Dio(),
    ),
  );

  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<LogoutSecretaryRepoImpl>(
    LogoutSecretaryRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<ForgotPasswordRepoImpl>(
    ForgotPasswordRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<VerificationRepoImpl>(
    VerificationRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<DepartmentRepoImpl>(
    DepartmentRepoImpl(
        getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<CourseRepoImpl>(
    CourseRepoImpl(
        getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<StudentRepoImpl>(
    StudentRepoImpl(
        getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<TrainerRepoImpl>(
    TrainerRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<ReportRepoImpl>(
    ReportRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<ComplainRepoImpl>(
    ComplainRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );
}