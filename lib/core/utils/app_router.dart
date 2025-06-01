import 'package:go_router/go_router.dart';

import '../../features/login/presentation/views/login_secretary_view.dart';
import '../../features/profile/presentaion/views/profile_view.dart';
import '../../features/secretary_features/complain/presentation/views/complain_details_view.dart';
import '../../features/secretary_features/complain/presentation/views/complains_view.dart';
import '../../features/secretary_features/complain/presentation/views/search_complain_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/announcement_c_details_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/announcement_c_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/complete_calendar_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/complete_details_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/complete_students_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/complete_trainers_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/complete_view.dart';
import '../../features/secretary_features/course/presentation/views/announcement_a_details_view.dart';
import '../../features/secretary_features/course/presentation/views/announcement_a_view.dart';
import '../../features/secretary_features/course/presentation/views/calendar_view.dart';
import '../../features/secretary_features/course/presentation/views/course_details_view.dart';
import '../../features/secretary_features/course/presentation/views/courses_view.dart';
import '../../features/secretary_features/course/presentation/views/search_course_view.dart';
import '../../features/secretary_features/course/presentation/views/search_student_section_view.dart';
import '../../features/secretary_features/course/presentation/views/search_trainer_section_view.dart';
import '../../features/secretary_features/course/presentation/views/section_students_view.dart';
import '../../features/secretary_features/course/presentation/views/section_trainer_view.dart';
import '../../features/secretary_features/department/presentation/views/departments_view.dart';
import '../../features/secretary_features/forgot_password/presentation/views/forgot_password_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_details_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_calendar_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_view.dart';
import '../../features/secretary_features/report/presentation/views/details_report_view.dart';
import '../../features/secretary_features/report/presentation/views/reports_view.dart';
import '../../features/secretary_features/student/presentation/views/archive_section_student_view.dart';
import '../../features/secretary_features/student/presentation/views/search_student_view.dart';
import '../../features/secretary_features/student/presentation/views/student_archive_course_view.dart';
import '../../features/secretary_features/student/presentation/views/student_details_view.dart';
import '../../features/secretary_features/trainer/presentation/views/archive_section_trainer_view.dart';
import '../../features/secretary_features/trainer/presentation/views/search_trainer_view.dart';
import '../../features/secretary_features/trainer/presentation/views/trainer_archive_course_view.dart';
import '../../features/secretary_features/trainer/presentation/views/trainer_details_view.dart';
import '../../features/secretary_features/trainer/presentation/views/trainers_view.dart';
import '../../features/secretary_features/verification/presentation/views/verification_view.dart';
import '../widgets/secretary/main_scaffold.dart';
import '../../features/secretary_features/student/presentation/views/students_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginView(),
        routes: [
          ShellRoute(
            builder: (context, state, child) => MainScaffold(child: child,),
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DepartmentsView(),
                routes: [
                  GoRoute(
                      path: '/courses/:departmentId',
                      builder: (context, state) {
                        final id = state.pathParameters['departmentId']!;
                        return CoursesView(departmentId: int.parse(id),);
                      },
                      routes: [
                        GoRoute(
                            path: '/details/:courseId',
                            builder: (context, state) {
                              final id = state.pathParameters['courseId']!;
                              return CourseDetailsView(courseId: int.parse(id),);
                            },
                            routes: [
                              GoRoute(
                                path: '/calendar/:sectionCalId',
                                builder: (context, state) {
                                  final id = state.pathParameters['sectionCalId']!;
                                  return CalendarView(sectionId: int.parse(id),);
                                },
                              ),
                              GoRoute(
                                path: '/sectionStudents/:sectionStudentId',
                                builder: (context, state) {
                                  final id = state.pathParameters['sectionStudentId']!;
                                  return SectionStudentsView(sectionId: int.parse(id),);
                                },
                                routes: [
                                  GoRoute(
                                    path: '/searchStudentSection/:sectionStudentId',
                                    builder: (context, state) {
                                      final id = state.pathParameters['sectionStudentId']!;
                                      return SearchStudentSectionView(sectionId: int.parse(id),);
                                    },
                                  ),
                                ]
                              ),
                              GoRoute(
                                path: '/sectionTrainers/:sectionId',
                                builder: (context, state) {
                                  final id = state.pathParameters['sectionId']!;
                                  return SectionTrainerView(sectionId: int.parse(id),);
                                },
                                routes: [
                                  GoRoute(
                                    path: '/searchTrainerSection/:sectionId',
                                    builder: (context, state) {
                                      final id = state.pathParameters['sectionId']!;
                                      return SearchTrainerSectionView(sectionId: int.parse(id),);
                                    },
                                  ),
                                ]
                              ),
                              GoRoute(
                                  path: '/announcementsA/:sectionAnnAId',
                                  builder: (context, state) {
                                    final id = state.pathParameters['sectionAnnAId']!;
                                    return AnnouncementAView(sectionId: int.parse(id),);
                                  },
                                  routes: [
                                    GoRoute(
                                      path: '/announcementADetails/:announcementId',
                                      builder: (context, state) {
                                        final id = state.pathParameters['announcementId']!;
                                        return AnnouncementADetailsView(id: int.parse(id),);
                                      },
                                    ),
                                  ]
                              ),
                            ]
                        ),
                        GoRoute(
                          path: '/searchCourse',
                          builder: (context, state) {
                            return SearchCourseView();
                          },
                        ),
                      ]
                  ),
                ]
              ),

              GoRoute(
                path: '/students',
                builder: (context, state) => const StudentsView(),
                routes: [
                  GoRoute(
                    path: '/studentDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return StudentDetailsView(id: int.parse(id),);
                    },
                      routes: [
                        GoRoute(
                            path: '/studentArchiveCourseView/:studentId',
                            builder: (context, state) {
                              final id = state.pathParameters['studentId']!;
                              return StudentArchiveCourseView(studentId: int.parse(id),);
                            },
                            routes: [
                              GoRoute(
                                  path: '/archiveSectionStudentView/:sectionId',
                                  builder: (context, state) {
                                    final id = state.pathParameters['sectionId']!;
                                    return ArchiveSectionStudentView(sectionId: int.parse(id),);
                                  },
                                  routes: [
                                    GoRoute(
                                      path: '/completeCalendar/:sectionCCalId',
                                      builder: (context, state) {
                                        final id = state.pathParameters['sectionCCalId']!;
                                        return CompleteCalendarView(sectionId: int.parse(id),);
                                      },
                                    ),
                                    GoRoute(
                                      path: '/completeStudents/:sectionCStudentsId',
                                      builder: (context, state) {
                                        final id = state.pathParameters['sectionCStudentsId']!;
                                        return CompleteStudentsView(sectionId: int.parse(id),);
                                      },
                                    ),
                                    GoRoute(
                                      path: '/completeTrainers/:sectionCId',
                                      builder: (context, state) {
                                        final id = state.pathParameters['sectionCId']!;
                                        return CompleteTrainersView(sectionId: int.parse(id),);
                                      },
                                    ),
                                  ]
                              ),
                            ]
                        ),
                      ]
                  ),
                  GoRoute(
                    path: '/searchStudent',
                    builder: (context, state) {
                      return SearchStudentView();
                    },
                  ),
                ]
              ),

              GoRoute(
                path: '/trainers',
                builder: (context, state) => const TrainersView(),
                routes: [
                  GoRoute(
                    path: '/trainerDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return TrainerDetailsView(id: int.parse(id),);
                    },
                      routes: [
                        GoRoute(
                            path: '/trainerArchiveCourseView/:trainerId',
                            builder: (context, state) {
                              final id = state.pathParameters['trainerId']!;
                              return TrainerArchiveCourseView(trainerId: int.parse(id),);
                            },
                            routes: [
                              GoRoute(
                                  path: '/archiveSectionTrainerView/:sectionId',
                                  builder: (context, state) {
                                    final id = state.pathParameters['sectionId']!;
                                    return ArchiveSectionTrainerView(sectionId: int.parse(id),);
                                  },
                                  routes: [
                                    GoRoute(
                                      path: '/completeCalendar/:sectionCCalId',
                                      builder: (context, state) {
                                        final id = state.pathParameters['sectionCCalId']!;
                                        return CompleteCalendarView(sectionId: int.parse(id),);
                                      },
                                    ),
                                    GoRoute(
                                      path: '/completeStudents/:sectionCStudentsId',
                                      builder: (context, state) {
                                        final id = state.pathParameters['sectionCStudentsId']!;
                                        return CompleteStudentsView(sectionId: int.parse(id),);
                                      },
                                    ),
                                    GoRoute(
                                      path: '/completeTrainers/:sectionCId',
                                      builder: (context, state) {
                                        final id = state.pathParameters['sectionCId']!;
                                        return CompleteTrainersView(sectionId: int.parse(id),);
                                      },
                                    ),
                                  ]
                              ),
                            ]
                        ),
                      ]
                  ),
                  GoRoute(
                    path: '/searchTrainer',
                    builder: (context, state) {
                      return SearchTrainerView();
                    },
                  ),
                ]
              ),

              GoRoute(
                path: '/complete',
                builder: (context, state) => const CompleteView(),
                routes: [
                  GoRoute(
                    path: '/completeDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return CompleteDetailsView(sectionId: int.parse(id),);
                    },
                    routes: [
                      GoRoute(
                        path: '/completeCalendar/:sectionCCalId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionCCalId']!;
                          return CompleteCalendarView(sectionId: int.parse(id),);
                        },
                      ),
                      GoRoute(
                        path: '/completeStudents/:sectionCStudentsId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionCStudentsId']!;
                          return CompleteStudentsView(sectionId: int.parse(id),);
                        },
                      ),
                      GoRoute(
                        path: '/completeTrainers/:sectionCId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionCId']!;
                          return CompleteTrainersView(sectionId: int.parse(id),);
                        },
                      ),
                      GoRoute(
                          path: '/announcementsC/:sectionAnnCId',
                          builder: (context, state) {
                            final id = state.pathParameters['sectionAnnCId']!;
                            return AnnouncementCView(sectionId: int.parse(id),);
                          },
                          routes: [
                            GoRoute(
                              path: '/announcementCDetails/:announcementCId',
                              builder: (context, state) {
                                final id = state.pathParameters['announcementCId']!;
                                return AnnouncementCDetailsView(id: int.parse(id),);
                              },
                            ),
                          ]
                      ),
                    ]
                  ),
                ]
              ),

              GoRoute(
                path: '/inPreparation',
                builder: (context, state) => const InPreparationView(),
                routes: [
                  GoRoute(
                    path: '/inPreparationDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return DetailsInPreparationView(sectionId: int.parse(id),);
                    },
                    routes: [
                      GoRoute(
                        path: '/inPreparationCalendar/:sectionIpCalId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionIpCalId']!;
                          return InPreparationCalendarView(sectionId: int.parse(id),);
                        },
                      ),
                    ]
                  ),
                ]
              ),

              GoRoute(
                path: '/reports',
                builder: (context, state) => const ReportsView(),
                routes: [
                  GoRoute(
                    path: '/detailsReport/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return DetailsReportView(id: int.parse(id),);
                    },
                  ),
                ]
              ),

              GoRoute(
                path: '/complains',
                builder: (context, state) => const ComplainsView(),
                routes: [
                  GoRoute(
                    path: '/complainDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return ComplainDetailsView(complainId: int.parse(id),);
                    },
                  ),
                  GoRoute(
                    path: '/searchComplain',
                    builder: (context, state) {
                      return SearchComplainView();
                    },
                  ),
                ]
              ),

              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileView(),
              ),
            ]
          )
        ]
      ),
      GoRoute(
        path: '/verification',
        builder: (context, state) => const ForgotPasswordView(),
        routes: [
          GoRoute(
            path: '/passwordReset',
            builder: (context, state) => const VerificationView(),
          ),
        ]
      ),
    ],
  );
}
