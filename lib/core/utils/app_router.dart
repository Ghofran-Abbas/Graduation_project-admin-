import 'package:admin_alhadara_dashboard/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/employee/presentation/views/employee_details_view.dart';
import '../../features/employee/presentation/views/employees_view.dart';
import '../../features/employee/presentation/views/search_employee_view.dart';
import '../../features/gifts/presentation/manager/gifts_cubit/gifts_cubit.dart';
import '../../features/gifts/presentation/views/secretary_gifts_view.dart';
import '../../features/gifts/presentation/views/student_gifts_view.dart';
import '../../features/login/presentation/views/login_secretary_view.dart';
import '../../features/points/data/repos/points_repo.dart';
import '../../features/points/data/repos/points_repo_impl.dart';
import '../../features/points/presentation/manager/top_secretaries_cubit/top_secretaries_cubit.dart';
import '../../features/points/presentation/manager/top_students_cubit/top_students_cubit.dart';
import '../../features/points/presentation/manager/update_points_cubit/update_points_cubit.dart';
import '../../features/points/presentation/manager/update_secretary_points_cubit/update_secretary_points_cubit.dart';
import '../../features/points/presentation/views/top_secretaries_view.dart';
import '../../features/points/presentation/views/top_students_view.dart';
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
import '../../features/secretary_features/complete_course/presentation/views/details_complete_trainer_view.dart';
import '../../features/secretary_features/course/presentation/views/announcement_a_details_view.dart';
import '../../features/secretary_features/course/presentation/views/announcement_a_view.dart';
import '../../features/secretary_features/course/presentation/views/calendar_view.dart';
import '../../features/secretary_features/course/presentation/views/course_details_view.dart';
import '../../features/secretary_features/course/presentation/views/courses_view.dart';
import '../../features/secretary_features/course/presentation/views/details_section_trainer_view.dart';
import '../../features/secretary_features/course/presentation/views/search_course_view.dart';
import '../../features/secretary_features/course/presentation/views/search_student_section_view.dart';
import '../../features/secretary_features/course/presentation/views/search_trainer_section_view.dart';
import '../../features/secretary_features/course/presentation/views/section_rating_view.dart';
import '../../features/secretary_features/course/presentation/views/section_students_view.dart';
import '../../features/secretary_features/course/presentation/views/section_trainer_view.dart';
import '../../features/secretary_features/course/presentation/views/trainer_rating_view.dart';
import '../../features/secretary_features/department/presentation/views/departments_view.dart';
import '../../features/secretary_features/forgot_password/presentation/views/forgot_password_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_details_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_calendar_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_students_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_trainers_view.dart';
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
import 'go_router_path.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginView(),
        routes: [
          ShellRoute(
            builder: (context, state, child) => MainScaffold(child: child),
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DepartmentsView(),
                routes: [
                  GoRoute(
                    path: '/courses/:departmentId',
                    builder: (context, state) {
                      final id = state.pathParameters['departmentId']!;
                      return CoursesView(departmentId: int.parse(id));
                    },
                    routes: [
                      GoRoute(
                        path: '/details/:courseId',
                        builder: (context, state) {
                          final id = state.pathParameters['courseId']!;
                          return CourseDetailsView(courseId: int.parse(id));
                        },
                        routes: [
                          GoRoute(
                            path: '/calendar/:sectionCalId',
                            builder: (context, state) {
                              final id = state.pathParameters['sectionCalId']!;
                              return CalendarView(sectionId: int.parse(id));
                            },
                          ),
                          GoRoute(
                            path: '/sectionRating/:sectionId',
                            builder: (context, state) {
                              final id = state.pathParameters['sectionId']!;
                              return SectionRatingView(sectionId: int.parse(id),);
                            },
                          ),
                          GoRoute(
                            path: '/sectionStudents/:departmentId/:sectionStudentId',
                            builder: (context, state) {
                              final id =
                                  state.pathParameters['sectionStudentId']!;
                              final dId = state.pathParameters['departmentId']!;
                              return SectionStudentsView(departmentId: int.parse(dId), sectionId: int.parse(id),);
                            },
                            routes: [
                              GoRoute(
                                path: '/searchStudentSection/:sectionStudentId',
                                builder: (context, state) {
                                  final id =
                                      state.pathParameters['sectionStudentId']!;
                                  return SearchStudentSectionView(
                                    sectionId: int.parse(id),
                                  );
                                },
                              ),
                            ],
                          ),
                          GoRoute(
                            path: '/sectionTrainers/:departmentId/:sectionId',
                            builder: (context, state) {
                              final id = state.pathParameters['sectionId']!;
                              final dId = state.pathParameters['departmentId']!;
                              return SectionTrainerView(departmentId: int.parse(dId), sectionId: int.parse(id),);
                            },
                            routes: [
                              GoRoute(
                                path: '/searchTrainerSection/:sectionId',
                                builder: (context, state) {
                                  final id = state.pathParameters['sectionId']!;
                                  return SearchTrainerSectionView(
                                    sectionId: int.parse(id),
                                  );
                                },
                              ),
                              GoRoute(
                                  path: '/detailsSectionTrainer/:departmentId/:courseId/:sectionId/:id',
                                  builder: (context, state) {
                                    final departmentId = state.pathParameters['departmentId']!;
                                    final courseId = state.pathParameters['courseId']!;
                                    final sectionId = state.pathParameters['sectionId']!;
                                    final id = state.pathParameters['id']!;
                                    return DetailsSectionTrainerView(departmentId: int.parse(departmentId), courseId: int.parse(courseId), sectionId: int.parse(sectionId), id: int.parse(id),);
                                  },
                                  routes: [
                                    GoRoute(
                                      path: '/trainerRating/:trainerId/:sectionId',
                                      builder: (context, state) {
                                        final trainerId = state.pathParameters['trainerId']!;
                                        final sectionId = state.pathParameters['sectionId']!;
                                        return TrainerRatingView(trainerId: int.parse(trainerId), sectionId: int.parse(sectionId),);
                                      },
                                    ),
                                    /*GoRoute(
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
                                      ),*/
                                  ]
                              ),
                            ],
                          ),
                          GoRoute(
                            path: '/announcementsA/:sectionAnnAId',
                            builder: (context, state) {
                              final id = state.pathParameters['sectionAnnAId']!;
                              return AnnouncementAView(
                                sectionId: int.parse(id),
                              );
                            },
                            routes: [
                              GoRoute(
                                path: '/announcementADetails/:announcementId',
                                builder: (context, state) {
                                  final id =
                                      state.pathParameters['announcementId']!;
                                  return AnnouncementADetailsView(
                                    id: int.parse(id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      GoRoute(
                        path: '/searchCourse',
                        builder: (context, state) {
                          return SearchCourseView();
                        },
                      ),
                    ],
                  ),
                ],
              ),

              GoRoute(
                path: '/students',
                builder: (context, state) => const StudentsView(),
                routes: [
                  GoRoute(
                    path: '/studentDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return StudentDetailsView(id: int.parse(id));
                    },
                    routes: [

                      GoRoute(
                        path: 'gifts',
                        builder: (ctx, state) {
                          final sid = int.parse(state.pathParameters['id']!);
                          return StudentGiftsView(studentId: sid);
                        },
                      ),


                      GoRoute(
                        path: '/studentArchiveCourseView/:studentId',
                        builder: (context, state) {
                          final id = state.pathParameters['studentId']!;
                          return StudentArchiveCourseView(
                            studentId: int.parse(id),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: '/archiveSectionStudentView/:sectionId/:courseId/:studentId',
                            builder: (context, state) {
                              final id = state.pathParameters['sectionId']!;
                              final courseId = state.pathParameters['courseId']!;
                              final studentId = state.pathParameters['studentId']!;
                              return ArchiveSectionStudentView(sectionId: int.parse(id), courseId: int.parse(courseId), studentId: int.parse(studentId),);
                            },
                            routes: [
                              GoRoute(
                                path: '/sectionRating/:sectionId',
                                builder: (context, state) {
                                  final id = state.pathParameters['sectionId']!;
                                  return SectionRatingView(sectionId: int.parse(id),);
                                },
                              ),
                              GoRoute(
                                path: '/completeCalendar/:sectionCCalId',
                                builder: (context, state) {
                                  final id =
                                      state.pathParameters['sectionCCalId']!;
                                  return CompleteCalendarView(
                                    sectionId: int.parse(id),
                                  );
                                },
                              ),
                              GoRoute(
                                path: '/completeStudents/:sectionCStudentsId',
                                builder: (context, state) {
                                  final id =
                                      state
                                          .pathParameters['sectionCStudentsId']!;
                                  return CompleteStudentsView(
                                    sectionId: int.parse(id),
                                  );
                                },
                              ),
                              GoRoute(
                                path: '/completeTrainers/:sectionCId',
                                builder: (context, state) {
                                  final id =
                                      state.pathParameters['sectionCId']!;
                                  return CompleteTrainersView(
                                    sectionId: int.parse(id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'top-students',
                    builder: (ctx, state) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) =>
                            TopStudentsCubit(getIt<PointsRepo>())..fetchTopStudents(limit: 10),
                          ),
                          BlocProvider(
                            create: (_) => UpdatePointsCubit(getIt<PointsRepo>()),
                          ),
                        ],
                        child: const TopStudentsView(),
                      );
                    },
                  ),

                  GoRoute(
                    path: '/searchStudent',
                    builder: (context, state) {
                      return SearchStudentView();
                    },
                  ),
                ],
              ),

              GoRoute(
                path: '/trainers',
                builder: (context, state) => const TrainersView(),
                routes: [
                  GoRoute(
                    path: '/trainerDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return TrainerDetailsView(id: int.parse(id));
                    },
                    routes: [
                      GoRoute(
                        path: '/trainerArchiveCourseView/:trainerId',
                        builder: (context, state) {
                          final id = state.pathParameters['trainerId']!;
                          return TrainerArchiveCourseView(
                            trainerId: int.parse(id),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: '/archiveSectionTrainerView/:sectionId/:courseId/:trainerId',
                            builder: (context, state) {
                              final id = state.pathParameters['sectionId']!;
                              final courseId = state.pathParameters['courseId']!;
                              final trainerId = state.pathParameters['trainerId']!;
                              return ArchiveSectionTrainerView(sectionId: int.parse(id), courseId: int.parse(courseId), trainerId: int.parse(trainerId),);
                            },
                            routes: [
                              GoRoute(
                                path: '/completeCalendar/:sectionCCalId',
                                builder: (context, state) {
                                  final id =
                                      state.pathParameters['sectionCCalId']!;
                                  return CompleteCalendarView(
                                    sectionId: int.parse(id),
                                  );
                                },
                              ),
                              GoRoute(
                                path: '/completeStudents/:sectionCStudentsId',
                                builder: (context, state) {
                                  final id =
                                      state
                                          .pathParameters['sectionCStudentsId']!;
                                  return CompleteStudentsView(
                                    sectionId: int.parse(id),
                                  );
                                },
                              ),
                              GoRoute(
                                path: '/completeTrainers/:sectionCId',
                                builder: (context, state) {
                                  final id =
                                      state.pathParameters['sectionCId']!;
                                  return CompleteTrainersView(
                                    sectionId: int.parse(id),
                                  );
                                },
                                  routes: [
                                    GoRoute(
                                        path: '/detailsCompleteTrainer/:sectionId/:trainerId',
                                        builder: (context, state) {
                                          final sectionId = state.pathParameters['sectionId']!;
                                          final id = state.pathParameters['trainerId']!;
                                          return DetailsCompleteTrainerView(sectionId: int.parse(sectionId), id: int.parse(id),);
                                        },
                                        routes: [
                                          GoRoute(
                                            path: '/trainerRating/:trainerId/:sectionId',
                                            builder: (context, state) {
                                              final trainerId = state.pathParameters['trainerId']!;
                                              final sectionId = state.pathParameters['sectionId']!;
                                              return TrainerRatingView(trainerId: int.parse(trainerId), sectionId: int.parse(sectionId),);
                                            },
                                          ),
                                          /*GoRoute(
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
                                    ),*/
                                        ]
                                    ),
                                  ]
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/searchTrainer',
                    builder: (context, state) {
                      return SearchTrainerView();
                    },
                  ),
                ],
              ),
              GoRoute(
                path: GoRouterPath.employees,
                builder: (context, state) => const EmployeesView(),
                routes: [
                  GoRoute(
                    path: 'top-secretary',
                    builder: (ctx, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (_) => TopSecretariesCubit(getIt<PointsRepo>())..fetchTopSecretaries(limit: 10),
                        ),
                        BlocProvider(
                          create: (_) => UpdateSecretaryPointsCubit(getIt<PointsRepo>()),
                        ),
                      ],
                      child: const TopSecretariesView(),
                    ),
                  ),
                  GoRoute(
                    path: 'searchEmployee',
                    builder: (context, state) => SearchEmployeeView(),
                  ),
                  GoRoute(
                    path: ':id',
                    name: 'employeeDetails',
                    builder: (context, state) {
                      final raw = state.pathParameters['id']!;
                      final id = int.tryParse(raw);
                      if (id == null) {
                        return Scaffold(
                          body: Center(
                            child: Text('Invalid employee ID: $raw'),
                          ),
                        );
                      }
                      return EmployeeDetailsView(id: id);
                    },
                    routes: [                      GoRoute(
                      path: 'gifts',
                      builder: (ctx, state) {
                        final sid = int.parse(state.pathParameters['id']!);
                        return SecretaryGiftsView(secretaryId: sid);
                      },
                    ),
                    ],
                  ),

                ],
              ),

              GoRoute(
                path: '/complete',
                builder: (context, state) => const CompleteView(),
                routes: [
                  GoRoute(
                    path: '/completeDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return CompleteDetailsView(courseId: int.parse(id));
                    },
                    routes: [
                      GoRoute(
                        path: '/completeCalendar/:sectionCCalId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionCCalId']!;
                          return CompleteCalendarView(sectionId: int.parse(id));
                        },
                      ),
                      GoRoute(
                        path: '/sectionRating/:sectionId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionId']!;
                          return SectionRatingView(sectionId: int.parse(id),);
                        },
                      ),
                      GoRoute(
                        path: '/completeStudents/:sectionCStudentsId',
                        builder: (context, state) {
                          final id =
                              state.pathParameters['sectionCStudentsId']!;
                          return CompleteStudentsView(sectionId: int.parse(id));
                        },
                      ),
                      GoRoute(
                        path: '/completeTrainers/:sectionCId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionCId']!;
                          return CompleteTrainersView(sectionId: int.parse(id));
                        },
                          routes: [
                            GoRoute(
                                path: '/detailsCompleteTrainer/:sectionId/:trainerId',
                                builder: (context, state) {
                                  final sectionId = state.pathParameters['sectionId']!;
                                  final id = state.pathParameters['trainerId']!;
                                  return DetailsCompleteTrainerView(sectionId: int.parse(sectionId), id: int.parse(id),);
                                },
                                routes: [
                                  GoRoute(
                                    path: '/trainerRating/:trainerId/:sectionId',
                                    builder: (context, state) {
                                      final trainerId = state.pathParameters['trainerId']!;
                                      final sectionId = state.pathParameters['sectionId']!;
                                      return TrainerRatingView(trainerId: int.parse(trainerId), sectionId: int.parse(sectionId),);
                                    },
                                  ),
                                  /*GoRoute(
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
                                    ),*/
                                ]
                            ),
                          ]
                      ),
                      GoRoute(
                        path: '/announcementsC/:sectionAnnCId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionAnnCId']!;
                          return AnnouncementCView(sectionId: int.parse(id));
                        },
                        routes: [
                          GoRoute(
                            path: '/announcementCDetails/:announcementCId',
                            builder: (context, state) {
                              final id =
                                  state.pathParameters['announcementCId']!;
                              return AnnouncementCDetailsView(
                                id: int.parse(id),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              GoRoute(
                path: '/inPreparation',
                builder: (context, state) => const InPreparationView(),
                routes: [
                  GoRoute(
                    path: '/inPreparationDetails/:courseId',
                    builder: (context, state) {
                      final id = state.pathParameters['courseId']!;
                      return DetailsInPreparationView(courseId: int.parse(id),);
                    },
                    routes: [
                      GoRoute(
                        path: '/inPreparationCalendar/:sectionIpCalId',
                        builder: (context, state) {
                          final id = state.pathParameters['sectionIpCalId']!;
                          return InPreparationCalendarView(
                            sectionId: int.parse(id),
                          );
                        },
                      ),
                      GoRoute(
                          path: '/inPreparationStudents/:sectionIpStudentsId',
                          builder: (context, state) {
                            final id = state.pathParameters['sectionIpStudentsId']!;
                            return InPreparationStudentsView(sectionId: int.parse(id),);
                          },
                      ),
                      GoRoute(
                          path: '/inPreparationTrainers/:sectionIpId',
                          builder: (context, state) {
                            final id = state.pathParameters['sectionIpId']!;
                            return InPreparationTrainersView(sectionId: int.parse(id),);
                          },
                      ),
                    ],
                  ),
                ],
              ),

              GoRoute(
                path: '/reports',
                builder: (context, state) => const ReportsView(),
                routes: [
                  GoRoute(
                    path: '/detailsReport/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return DetailsReportView(id: int.parse(id));
                    },
                  ),
                ],
              ),

              GoRoute(
                path: '/complains',
                builder: (context, state) => const ComplainsView(),
                routes: [
                  GoRoute(
                    path: '/complainDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return ComplainDetailsView(complainId: int.parse(id));
                    },
                  ),
                  GoRoute(
                    path: '/searchComplain',
                    builder: (context, state) {
                      return SearchComplainView();
                    },
                  ),
                ],
              ),

              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/verification',
        builder: (context, state) => const ForgotPasswordView(),
        routes: [
          GoRoute(
            path: '/passwordReset',
            builder: (context, state) => const VerificationView(),
          ),
        ],
      ),
    ],
  );
}
