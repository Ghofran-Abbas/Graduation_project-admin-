// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'core/localization/app_localizations_setup.dart';
// import 'core/localization/local_cubit/local_cubit.dart';
// import 'core/utils/app_router.dart';
// import 'core/utils/bloc_observer.dart';
// import 'core/utils/service_locator.dart';
// import 'features/employee/data/repos/employee_repo_impl.dart';
// import 'features/employee/presentation/manager/create_employee_cubit/create_employee_cubit.dart';
// import 'features/employee/presentation/manager/delete_employee_cubit/delete_employee_cubit.dart';
// import 'features/employee/presentation/manager/employees_cubit/employees_cubit.dart';
// import 'features/employee/presentation/manager/update_employee_cubit/update_employee_cubit.dart';
// import 'features/login/data/repos/login_secretary_repo_impl.dart';
// import 'features/login/presentation/manager/login_cubit/login_secretary_cubit.dart';
// import 'features/profile/presentaion/views/widgets/profile_view_body.dart';
// import 'features/secretary_features/department/data/repos/department_repo_impl.dart';
// import 'features/secretary_features/department/presentation/manager/departments_cubit/departments_cubit.dart';
// import 'features/secretary_features/logout/data/repos/logout_secretary_impl.dart';
// import 'features/secretary_features/logout/presentation/manager/logout_secretary_cubit/logout_secretary_cubit.dart';
// import 'features/secretary_features/student/data/repos/student_repo_impl.dart';
// import 'features/secretary_features/student/presentation/manager/students_cubit/students_cubit.dart';
// import 'features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
// import 'features/secretary_features/trainer/presentation/manager/trainers_cubit/trainers_cubit.dart';
//
// void main() {
//
//   setupServiceLocator();
//   Bloc.observer = MyBlocObserver();
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
//         BlocProvider(
//           create: (context) {
//             return LoginCubit(
//               getIt.get<LoginRepoImpl>(),
//             );
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return UserCubit(
//               //getIt.get<LoginRepoImpl>(),
//             )..loadUser();
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return LogoutSecretaryCubit(
//               getIt.get<LogoutSecretaryRepoImpl>(),
//             );
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return DepartmentsCubit(
//               getIt.get<DepartmentRepoImpl>(),
//             )..fetchDepartments(page: 1);
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return StudentsCubit(
//               getIt.get<StudentRepoImpl>(),
//             )..fetchStudents(page: 1);
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return TrainersCubit(
//               getIt.get<TrainerRepoImpl>(),
//             )..fetchTrainers(page: 1);
//           },
//         ),
//         // Employees list + create/update/delete
//   /*      BlocProvider(
//           create: (_) => EmployeesCubit(getIt.get<EmployeeRepoImpl>())..fetchEmployees(),
//         ),
//         BlocProvider(
//           create: (_) => CreateEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
//         ),
//         BlocProvider(
//           create: (_) => UpdateEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
//         ),
//         BlocProvider(
//           create: (_) => DeleteEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
//         ),
// */
//       ],
//       child: BlocBuilder<LocaleCubit, Locale>(
//         builder: (context, locale) {
//           return ScreenUtilInit(
//             designSize: const Size(1440, 1024),
//             minTextAdapt: true,
//             splitScreenMode: true,
//             builder: (context, child) {
//               return MaterialApp.router(
//                 routerDelegate: AppRouter.router.routerDelegate,
//                 routeInformationParser: AppRouter.router.routeInformationParser,
//                 routeInformationProvider: AppRouter.router.routeInformationProvider,
//                 debugShowCheckedModeBanner: false,
//                 supportedLocales: AppLocalizationsSetup.supportedLocales,
//                 localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
//                 localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
//                 locale: locale,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }











import 'package:admin_alhadara_dashboard/features/ads/presentation/manager/getAllAdsCubit/singleAdCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/localization/app_localizations_setup.dart';
import 'core/localization/local_cubit/local_cubit.dart';
import 'core/utils/app_router.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/service_locator.dart';
import 'features/ads/data/repos/getAllAds_repo.dart';
import 'features/ads/presentation/manager/getAllAdsCubit/active_cubit.dart';
import 'features/ads/presentation/manager/getAllAdsCubit/getAllAdsCubit.dart';
import 'features/employee/data/repos/employee_repo_impl.dart';
import 'features/employee/presentation/manager/create_employee_cubit/create_employee_cubit.dart';
import 'features/employee/presentation/manager/delete_employee_cubit/delete_employee_cubit.dart';
import 'features/employee/presentation/manager/employees_cubit/employees_cubit.dart';
import 'features/employee/presentation/manager/update_employee_cubit/update_employee_cubit.dart';
import 'features/login/data/repos/login_secretary_repo_impl.dart';
import 'features/login/presentation/manager/login_cubit/login_secretary_cubit.dart';
import 'features/profile/presentaion/views/widgets/profile_view_body.dart';
import 'features/secretary_features/department/data/repos/department_repo_impl.dart';
import 'features/secretary_features/department/presentation/manager/departments_cubit/departments_cubit.dart';
import 'features/secretary_features/logout/data/repos/logout_secretary_impl.dart';
import 'features/secretary_features/logout/presentation/manager/logout_secretary_cubit/logout_secretary_cubit.dart';
import 'features/secretary_features/student/data/repos/student_repo_impl.dart';
import 'features/secretary_features/student/presentation/manager/students_cubit/students_cubit.dart';
import 'features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'features/secretary_features/trainer/presentation/manager/trainers_cubit/trainers_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
//
// void main()async {
//
//   setupServiceLocator();
//   Bloc.observer = MyBlocObserver();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   runApp(const RootApp());
// }
// class RootApp extends StatefulWidget {
//   const RootApp({Key? key}) : super(key: key);
//   @override
//   State<RootApp> createState() => _RootAppState();
// }
//
// class _RootAppState extends State<RootApp> {
//   @override
//   void initState() {
//     super.initState();
//     _setupFCM();
//   }
//
//   Future<void> _setupFCM() async {
//     final messaging = FirebaseMessaging.instance;
//
//     // طلب إذن الإشعارات
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     if (settings.authorizationStatus != AuthorizationStatus.authorized) {
//       debugPrint('🚫 Permission denied');
//       return;
//     }
//
//     // جلب الـ token
//     try {
//       final token = await messaging.getToken(
//         vapidKey: 'BMUIu0ik_OZJ9r9n3GPXib5fouwP02aKUqHBPJZFio406nmC_henlk7OtEco9fc5xd7Q3q_tZM0RuP6oBBPqTPc',
//       );
//       debugPrint('🔑 FCM Token: $token');
//     } catch (e) {
//       debugPrint('❌ FCM token error: $e');
//     }
//
//     // استماع للرسائل عند الـ foreground
//     FirebaseMessaging.onMessage.listen((msg) {
//       debugPrint('📬 Message: ${msg.notification}');
//     });
//   }
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
//         BlocProvider(
//           create: (context) {
//             return LoginCubit(
//               getIt.get<LoginRepoImpl>(),
//             );
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return UserCubit(
//               //getIt.get<LoginRepoImpl>(),
//             )..loadUser();
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return LogoutSecretaryCubit(
//               getIt.get<LogoutSecretaryRepoImpl>(),
//             );
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return DepartmentsCubit(
//               getIt.get<DepartmentRepoImpl>(),
//             )..fetchDepartments(page: 1);
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return StudentsCubit(
//               getIt.get<StudentRepoImpl>(),
//             )..fetchStudents(page: 1);
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return TrainersCubit(
//               getIt.get<TrainerRepoImpl>(),
//             )..fetchTrainers(page: 1);
//           },
//         ),
//
//         //Batool
//         BlocProvider<AdsCubit>(
//           create: (_) => getIt<AdsCubit>()..fetchAds(page: 1),
//         ),
//
//         BlocProvider<ActiveAdsCubit>(
//             create: (_) => getIt<ActiveAdsCubit>()..fetchActiveAds(page: 1),
//
//         )
//
//         // Employees list + create/update/delete
//         /*      BlocProvider(
//           create: (_) => EmployeesCubit(getIt.get<EmployeeRepoImpl>())..fetchEmployees(),
//         ),
//         BlocProvider(
//           create: (_) => CreateEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
//         ),
//         BlocProvider(
//           create: (_) => UpdateEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
//         ),
//         BlocProvider(
//           create: (_) => DeleteEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
//         ),
// */
//       ],
//       child: BlocBuilder<LocaleCubit, Locale>(
//         builder: (context, locale) {
//           return ScreenUtilInit(
//             designSize: const Size(1440, 1024),
//             minTextAdapt: true,
//             splitScreenMode: true,
//             builder: (context, child) {
//               return MaterialApp.router(
//                 routerDelegate: AppRouter.router.routerDelegate,
//                 routeInformationParser: AppRouter.router.routeInformationParser,
//                 routeInformationProvider: AppRouter.router.routeInformationProvider,
//                 debugShowCheckedModeBanner: false,
//                 supportedLocales: AppLocalizationsSetup.supportedLocales,
//                 localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
//                 localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
//                 locale: locale,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }











// ⚠️ الملف مخصص للويب (نستخدم dart:html لعرض إشعارات المتصفح)
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // على الويب، إشعارات الخلفية تُدار عبر Service Worker،
  // إبقاء هذا الهاندلر لا يضر ومفيد للموبايل إذا بنيت لاحقًا.
  print('🔧 BG message (Dart): ${message.messageId}');
}

/// يهيّئ FCM ويطبع الـ token قبل تحميل أي UI
Future<void> _initFCMAndPrintTokenPreUI() async {
  final messaging = FirebaseMessaging.instance;

  // طلب إذن الإشعارات قبل الواجهات
  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    debugPrint('🚫 Permission denied (no token)');
    return;
  }

  // جلب التوكن (الويب يحتاج VAPID)
  try {
    final token = await messaging.getToken(
      vapidKey:
      'BMUIu0ik_OZJ9r9n3GPXib5fouwP02aKUqHBPJZFio406nmC_henlk7OtEco9fc5xd7Q3q_tZM0RuP6oBBPqTPc',
    );
    debugPrint('🔑 FCM Token (pre-UI): $token');
    // TODO: أرسِل التوكن لسيرفرك هنا إذا رغبت
  } catch (e) {
    debugPrint('❌ FCM getToken error: $e');
  }

  // الاستماع لتجديد التوكن مبكرًا
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    debugPrint('🔁 Token refreshed: $newToken');
    // TODO: حدّث التوكن في السيرفر
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  Bloc.observer = MyBlocObserver();

  // تهيئة Firebase بالقيم المولّدة من FlutterFire CLI
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // هاندلر الخلفية (لن يؤثر على الويب لكن آمن)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // ✅ اطبع التوكن قبل أي واجهات
  await _initFCMAndPrintTokenPreUI();

  // شغّل الواجهات
  runApp(const RootApp());
}

// ====== تطبيقك كما هو مع مزوّدي الـ Bloc ======

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);
  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  void initState() {
    super.initState();
    _setupForegroundHandlers();
  }

  /// عند استقبال رسالة والصفحة مفتوحة:
  /// - نحاول عرض Browser Notification
  /// - وإلا نعرض SnackBar كبديل
  void _setupForegroundHandlers() {
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) async {
      final title =
          msg.notification?.title ?? msg.data['title'] ?? 'Notification';
      final body = msg.notification?.body ?? msg.data['body'] ?? '';

      bool shownAsBrowserNotification = false;

      try {
        // إن لم يكن الإذن ممنوحًا لإشعارات المتصفح، اطلبه (لن يظهر مربع إن كان مرفوضًا مسبقًا)
        if (html.Notification.permission != 'granted') {
          await html.Notification.requestPermission();
        }
        if (html.Notification.permission == 'granted') {
          html.Notification(title, body: body, icon: '/icons/Icon-192.png');
          shownAsBrowserNotification = true;
        }
      } catch (e) {
        // تجاهل أي خطأ هنا (قد يحدث في بيئات لا تدعم Notification API)
        debugPrint('⚠️ Browser Notification error: $e');
      }

      // إن لم نعرض إشعار المتصفح، اعرض SnackBar داخل التطبيق
      if (!shownAsBrowserNotification && mounted) {
        if (title.isNotEmpty || body.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title\n$body')),
          );
        }
      }

      debugPrint('📬 Foreground message: ${msg.messageId} | ${msg.data}');
    });

    // فتح التطبيق من إشعار (للمنصات التي تدعم ذلك)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      debugPrint('🔔 Opened from notification: ${msg.messageId}');
      // TODO: وجّه المستخدم بناءً على msg.data (إن رغبت)
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
        BlocProvider(
          create: (context) {
            return LoginCubit(
              getIt.get<LoginRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UserCubit()..loadUser();
          },
        ),
        BlocProvider(
          create: (context) {
            return LogoutSecretaryCubit(
              getIt.get<LogoutSecretaryRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DepartmentsCubit(
              getIt.get<DepartmentRepoImpl>(),
            )..fetchDepartments(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return StudentsCubit(
              getIt.get<StudentRepoImpl>(),
            )..fetchStudents(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return TrainersCubit(
              getIt.get<TrainerRepoImpl>(),
            )..fetchTrainers(page: 1);
          },
        ),

        // Batool
        BlocProvider<AdsCubit>(
          create: (_) => getIt<AdsCubit>()..fetchAds(page: 1),
        ),
        BlocProvider<ActiveAdsCubit>(
          create: (_) =>
          getIt<ActiveAdsCubit>()..fetchActiveAds(page: 1),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(1440, 1024),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                routerDelegate: AppRouter.router.routerDelegate,
                routeInformationParser:
                AppRouter.router.routeInformationParser,
                routeInformationProvider:
                AppRouter.router.routeInformationProvider,
                debugShowCheckedModeBanner: false,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
                localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
                locale: locale,
              );
            },
          );
        },
      ),
    );
  }
}