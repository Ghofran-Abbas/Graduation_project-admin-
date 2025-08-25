import 'dart:math' as math;
import 'package:admin_alhadara_dashboard/features/dashboard/presentation/views/widgets/section_ratings_card_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';

import '../../manager/top_courses_cubit/top_courses_cubit.dart';
import '../../manager/top_courses_cubit/top_courses_state.dart';
import '../../manager/yearly_students_cubit/yearly_students_cubit.dart';
import '../../manager/yearly_students_cubit/yearly_students_state.dart';
import '../../manager/monthly_students_cubit/monthly_students_cubit.dart';
import '../../manager/monthly_students_cubit/monthly_students_state.dart';

import 'dashboard_card.dart';
import 'top_courses_donut.dart';
import 'top_courses_ranked_list.dart';
import 'yearly_students_line_chart.dart';
import 'monthly_students_bar_chart.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  bool _hideZeros = true; // for top-courses panel
  int? _selectedYearForMonthly;

  double _cardWidth(BoxConstraints c) {
    if (c.maxWidth >= 1100) return (c.maxWidth - 20.w) / 2;
    return c.maxWidth;
  }

  List<Color> _buildPalette(Color base, int n) {
    final hsl = HSLColor.fromColor(base);
    final List<Color> out = [];
    for (var i = 0; i < n; i++) {
      final hue = (hsl.hue + i * (360 / math.max(n, 6))) % 360;
      final sat = (hsl.saturation * 0.9).clamp(0.35, 0.95);
      final light = (hsl.lightness * 0.6).clamp(0.35, 0.7);
      out.add(HSLColor.fromAHSL(1, hue, sat, light).toColor());
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(top: 56.h),
      child: CustomScreenBody(
        title: loc.translate('Dashboard'),
        showSearchField: false,
        showFirstButton: false,
        showSecondButton: false,
        onPressedFirst: () {},
        onPressedSecond: () {},
        body: Padding(
          padding: EdgeInsets.only(top: 140.h, left: 20.w, right: 20.w, bottom: 27.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = _cardWidth(constraints);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // ====== Top Courses card ======
                    Wrap(
                      runSpacing: 20.h,
                      spacing: 20.w,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: DashboardCard(
                            title: loc.translate('Top courses by student registrations'),
                            subtitle: loc.translate('Most registered courses (live)'),
                            actions: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(loc.translate('Hide 0s'), style: TextStyle(fontSize: 12.sp)),
                                  SizedBox(width: 6.w),
                                  Switch.adaptive(
                                    value: _hideZeros,
                                    onChanged: (v) => setState(() => _hideZeros = v),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ],
                              ),
                            ],
                            child: BlocBuilder<TopCoursesCubit, TopCoursesState>(
                              builder: (context, state) {
                                if (state is TopCoursesLoading) {
                                  return SizedBox(height: 300.h, child: const Center(child: CustomCircularProgressIndicator()));
                                }
                                if (state is TopCoursesFailure) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomErrorWidget(errorMessage: state.error),
                                      SizedBox(height: 12.h),
                                      SizedBox(
                                        height: 36.h,
                                        child: ElevatedButton.icon(
                                          onPressed: () => context.read<TopCoursesCubit>().load(),
                                          icon: const Icon(Icons.refresh_rounded),
                                          label: Text(loc.translate('Retry')),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (state is TopCoursesSuccess) {
                                  var items = [...state.items]..sort((a, b) => b.totalStudents.compareTo(a.totalStudents));
                                  if (_hideZeros) items = items.where((e) => e.totalStudents > 0).toList();

                                  final total = state.items.fold<int>(0, (s, e) => s + e.totalStudents);
                                  final withStudents = state.items.where((e) => e.totalStudents > 0).length;

                                  if (state.items.isEmpty) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 30.h),
                                      child: Column(
                                        children: [
                                          Icon(Icons.insights_outlined, size: 40.sp, color: Colors.black38),
                                          SizedBox(height: 10.h),
                                          Text(loc.translate('No data yet'), style: TextStyle(fontSize: 14.sp, color: Colors.black54)),
                                        ],
                                      ),
                                    );
                                  }

                                  final palette = _buildPalette(Theme.of(context).colorScheme.primary, items.length);

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          _KpiTile(label: loc.translate('Total registrations'), value: total.toString()),
                                          SizedBox(width: 12.w),
                                          _KpiTile(label: loc.translate('Courses with students'), value: '$withStudents/${state.items.length}'),
                                        ],
                                      ),
                                      SizedBox(height: 14.h),
                                      LayoutBuilder(
                                        builder: (ctx, cons) {
                                          final isWide = cons.maxWidth > 760;
                                          if (isWide) {
                                            return Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 300.w,
                                                  height: 220.h,
                                                  child: TopCoursesDonut(items: items, colors: palette),
                                                ),
                                                SizedBox(width: 16.w),
                                                Expanded(child: TopCoursesRankedList(items: items, colors: palette)),
                                              ],
                                            );
                                          }
                                          return Column(
                                            children: [
                                              SizedBox(width: 260.w, height: 200.h, child: TopCoursesDonut(items: items, colors: palette)),
                                              SizedBox(height: 12.h),
                                              TopCoursesRankedList(items: items, colors: palette),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // ====== Yearly & Monthly cards ======
                    BlocListener<YearlyStudentsCubit, YearlyStudentsState>(
                      listenWhen: (prev, curr) => curr is YearlyStudentsSuccess,
                      listener: (context, state) {
                        final s = state as YearlyStudentsSuccess;
                        if (s.items.isNotEmpty) {
                          final latestYear = s.items.map((e) => e.year).reduce((a, b) => a > b ? a : b);
                          if (_selectedYearForMonthly == null) {
                            setState(() => _selectedYearForMonthly = latestYear);
                            context.read<MonthlyStudentsCubit>().load(year: latestYear);
                          }
                        }
                      },
                      child: Wrap(
                        runSpacing: 20.h,
                        spacing: 20.w,
                        children: [
                          // Yearly card
                          SizedBox(
                            width: cardWidth,
                            child: DashboardCard(
                              title: loc.translate('Yearly student registrations'),
                              subtitle: loc.translate('Trend over years'),
                              child: BlocBuilder<YearlyStudentsCubit, YearlyStudentsState>(
                                builder: (context, state) {
                                  if (state is YearlyStudentsLoading) {
                                    return SizedBox(height: 260.h, child: const Center(child: CustomCircularProgressIndicator()));
                                  }
                                  if (state is YearlyStudentsFailure) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomErrorWidget(errorMessage: state.error),
                                        SizedBox(height: 12.h),
                                        SizedBox(
                                          height: 36.h,
                                          child: ElevatedButton.icon(
                                            onPressed: () => context.read<YearlyStudentsCubit>().load(),
                                            icon: const Icon(Icons.refresh_rounded),
                                            label: Text(loc.translate('Retry')),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  if (state is YearlyStudentsSuccess) {
                                    final items = state.items;
                                    final totalAllYears = items.fold<int>(0, (s, e) => s + e.totalStudents);
                                    final growth = (items.length >= 2)
                                        ? (items.last.totalStudents - items[items.length - 2].totalStudents)
                                        : 0;
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            _KpiTile(label: loc.translate('Total'), value: totalAllYears.toString()),
                                            SizedBox(width: 12.w),
                                            _KpiTile(
                                              label: loc.translate('Last Δ'),
                                              value: (growth >= 0 ? '+$growth' : '$growth'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                        SizedBox(height: 260.h, child: YearlyStudentsLineChart(items: items)),
                                      ],
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),

                          // Monthly card
                          SizedBox(
                            width: cardWidth,
                            child: DashboardCard(
                              title: loc.translate('Monthly student registrations'),
                              subtitle: loc.translate('Selected year'),
                              actions: [
                                BlocBuilder<YearlyStudentsCubit, YearlyStudentsState>(
                                  builder: (context, yState) {
                                    final years = (yState is YearlyStudentsSuccess)
                                        ? (yState.items.map((e) => e.year).toList()..sort())
                                        : <int>[];
                                    return DropdownButton<int>(
                                      value: _selectedYearForMonthly != null && years.contains(_selectedYearForMonthly) ? _selectedYearForMonthly : null,
                                      hint: Text(loc.translate('Year')),
                                      items: years.map((y) => DropdownMenuItem(value: y, child: Text('$y'))).toList(),
                                      onChanged: (y) {
                                        if (y == null) return;
                                        setState(() => _selectedYearForMonthly = y);
                                        context.read<MonthlyStudentsCubit>().load(year: y);
                                      },
                                    );
                                  },
                                ),
                              ],
                              child: BlocBuilder<MonthlyStudentsCubit, MonthlyStudentsState>(
                                builder: (context, state) {
                                  if (_selectedYearForMonthly == null) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 24.h),
                                      child: Center(
                                        child: Text(loc.translate('Select a year'), style: TextStyle(color: Colors.black54)),
                                      ),
                                    );
                                  }
                                  if (state is MonthlyStudentsLoading) {
                                    return SizedBox(height: 260.h, child: const Center(child: CustomCircularProgressIndicator()));
                                  }
                                  if (state is MonthlyStudentsFailure) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomErrorWidget(errorMessage: state.error),
                                        SizedBox(height: 12.h),
                                        SizedBox(
                                          height: 36.h,
                                          child: ElevatedButton.icon(
                                            onPressed: () => context.read<MonthlyStudentsCubit>().load(year: _selectedYearForMonthly!),
                                            icon: const Icon(Icons.refresh_rounded),
                                            label: Text(loc.translate('Retry')),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  if (state is MonthlyStudentsSuccess) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            _KpiTile(label: '${loc.translate('Year')} ${state.year}', value: state.total.toString()),
                                            SizedBox(width: 12.w),
                                            _KpiTile(label: loc.translate('Active months'), value: state.items.where((m) => m.totalStudents > 0).length.toString()),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                        SizedBox(height: 260.h, child: MonthlyStudentsBarChart(items: state.items)),
                                      ],
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),

                          // ===== Section Ratings card =====
                          SizedBox(
                            width: cardWidth,
                            child: DashboardCard(
                              title: loc.translate('Section ratings statistics'),
                              subtitle: loc.translate('Filter by date, limit & order'),
                              child: SectionRatingsCardContent(buildPalette: _buildPalette),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _KpiTile extends StatelessWidget {
  final String label;
  final String value;
  const _KpiTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.03),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800)),
          SizedBox(width: 8.w),
          Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.black54, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
