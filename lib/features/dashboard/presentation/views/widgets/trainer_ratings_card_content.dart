import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../manager/trainer_ratings_cubit/trainer_ratings_cubit.dart';
import '../../manager/trainer_ratings_cubit/trainer_ratings_state.dart';
import 'trainer_ratings_bar_chart.dart';
import 'trainer_ratings_legend.dart';

class TrainerRatingsCardContent extends StatefulWidget {
  final List<Color> Function(Color base, int n) buildPalette;
  const TrainerRatingsCardContent({super.key, required this.buildPalette});

  @override
  State<TrainerRatingsCardContent> createState() => _TrainerRatingsCardContentState();
}

class _TrainerRatingsCardContentState extends State<TrainerRatingsCardContent> {
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

  void _apply() {
    context.read<TrainerRatingsCubit>().load(
      start: _start,
      end: _end,
      limit: _limit,
      order: _order,
    );
  }

  void _reset() {
    setState(() {
      _start = null;
      _end = null;
      _limit = 5;
      _order = 'desc';
    });
    _apply();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Filters row (matches SectionRatings look) ──
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _pickStart,
              icon: const Icon(Icons.event_outlined),
              label: Text(_start == null ? loc.translate('Start') : _start!.toIso8601String().substring(0, 10)),
            ),
            OutlinedButton.icon(
              onPressed: _pickEnd,
              icon: const Icon(Icons.event),
              label: Text(_end == null ? loc.translate('End') : _end!.toIso8601String().substring(0, 10)),
            ),
            // ▼ Limit as simple dropdown like your section card
            DropdownButton<int>(
              value: _limit,
              items: const [5, 10, 15, 20]
                  .map((e) => DropdownMenuItem<int>(
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
              onPressed: _apply,
              icon: const Icon(Icons.tune_rounded),
              label: Text(loc.translate('Apply')),
            ),
            TextButton(
              onPressed: _reset,
              child: Text(loc.translate('Reset')),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // ── Content ──
        BlocBuilder<TrainerRatingsCubit, TrainerRatingsState>(
          builder: (context, state) {
            if (state is TrainerRatingsLoading) {
              return SizedBox(height: 220.h, child: const Center(child: CustomCircularProgressIndicator()));
            }
            if (state is TrainerRatingsFailure) {
              return Column(
                children: [
                  CustomErrorWidget(errorMessage: state.error),
                  SizedBox(height: 8.h),
                  ElevatedButton.icon(
                    onPressed: _apply,
                    icon: const Icon(Icons.refresh),
                    label: Text(loc.translate('Retry')),
                  ),
                ],
              );
            }
            if (state is TrainerRatingsSuccess) {
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
                  final wide = cons.maxWidth > 760;
                  if (wide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300.w,
                          height: 220.h,
                          child: TrainerRatingsBarChart(items: items, colors: palette),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(child: TrainerRatingsLegend(items: items, colors: palette)),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(width: 260.w, height: 200.h, child: TrainerRatingsBarChart(items: items, colors: palette)),
                      SizedBox(height: 12.h),
                      TrainerRatingsLegend(items: items, colors: palette),
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
