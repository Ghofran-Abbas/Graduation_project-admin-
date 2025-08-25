import 'package:admin_alhadara_dashboard/features/dashboard/presentation/views/widgets/section_ratings_bar_chart.dart';
import 'package:admin_alhadara_dashboard/features/dashboard/presentation/views/widgets/section_ratings_legend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../manager/section_ratings_cubit/section_ratings_cubit.dart';
import '../../manager/section_ratings_cubit/section_ratings_state.dart';

class SectionRatingsCardContent extends StatefulWidget {
  final List<Color> Function(Color base, int n) buildPalette;
  const SectionRatingsCardContent({required this.buildPalette});

  @override
  State<SectionRatingsCardContent> createState() => _SectionRatingsCardContentState();
}

class _SectionRatingsCardContentState extends State<SectionRatingsCardContent> {
  DateTime? _start;
  DateTime? _end;
  int _limit = 5;
  String _order = 'desc';

  Future<void> _pickStart() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _start ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
    );
    if (d != null) setState(() => _start = d);
  }

  Future<void> _pickEnd() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _end ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
    );
    if (d != null) setState(() => _end = d);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filters row
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _pickStart,
              icon: const Icon(Icons.event_outlined),
              label: Text(_start == null ? loc.translate('Start') : _start!.toIso8601String().substring(0,10)),
            ),
            OutlinedButton.icon(
              onPressed: _pickEnd,
              icon: const Icon(Icons.event),
              label: Text(_end == null ? loc.translate('End') : _end!.toIso8601String().substring(0,10)),
            ),
            DropdownButton<int>(
              value: _limit,
              items: const [5,10,15,20]
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text('${loc.translate('Limit')} $e'),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _limit = v ?? 5),
            ),
            DropdownButton<String>(
              value: _order,
              items: [
                DropdownMenuItem(value: 'desc', child: Text(loc.translate('DESC'))),
                DropdownMenuItem(value: 'asc', child: Text(loc.translate('ASC'))),
              ],
              onChanged: (v) => setState(() => _order = v ?? 'desc'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                context.read<SectionRatingsCubit>().load(
                  start: _start,
                  end: _end,
                  limit: _limit,
                  order: _order,
                );
              },
              icon: const Icon(Icons.tune_rounded),
              label: Text(loc.translate('Apply')),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _start = null;
                  _end = null;
                  _limit = 5;
                  _order = 'desc';
                });
                context.read<SectionRatingsCubit>().load(
                  start: DateTime.now().subtract(const Duration(days: 60)),
                  end: DateTime.now(),
                  limit: 5,
                  order: 'desc',
                );
              },
              child: Text(loc.translate('Reset')),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Content
        BlocBuilder<SectionRatingsCubit, SectionRatingsState>(
          builder: (context, state) {
            if (state is SectionRatingsLoading) {
              return SizedBox(height: 260.h, child: const Center(child: CircularProgressIndicator()));
            }
            if (state is SectionRatingsFailure) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.error, style: const TextStyle(color: Colors.red)),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 36.h,
                    child: ElevatedButton.icon(
                      onPressed: () => context.read<SectionRatingsCubit>().load(
                        start: _start, end: _end, limit: _limit, order: _order,
                      ),
                      icon: const Icon(Icons.refresh),
                      label: Text(loc.translate('Retry')),
                    ),
                  ),
                ],
              );
            }
            if (state is SectionRatingsSuccess) {
              final items = state.items;
              if (items.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Center(child: Text(loc.translate('No data in selected range'))),
                );
              }
              final palette = widget.buildPalette(primary, items.length);

              return LayoutBuilder(
                builder: (ctx, cons) {
                  final isWide = cons.maxWidth > 760;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 260.h,
                            child: SectionRatingsBarChart(items: items, colors: palette),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: SectionRatingsLegend(items: items, colors: palette),
                          ),
                        ),
                      ],
                    );
                  }
                  // stacked
                  return Column(
                    children: [
                      SizedBox(height: 260.h, child: SectionRatingsBarChart(items: items, colors: palette)),
                      SizedBox(height: 10.h),
                      SectionRatingsLegend(items: items, colors: palette),
                    ],
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
