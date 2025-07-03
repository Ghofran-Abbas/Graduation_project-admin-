// lib/features/gifts/presentation/views/widgets/gifts_view_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../data/models/gift_model.dart';
import '../../manager/create_gift_cubit/create_gift_cubit.dart';
import '../../manager/create_gift_cubit/create_gift_state.dart';
import '../../manager/delete_gift_cubit/delete_gift_cubit.dart';
import '../../manager/delete_gift_cubit/delete_gift_state.dart';
import '../../manager/gifts_cubit/gifts_cubit.dart';
import '../../manager/gifts_cubit/gifts_state.dart';
import '../../manager/update_gift_cubit/update_gift_cubit.dart';
import '../../manager/update_gift_cubit/update_gift_state.dart';

import 'gift_form_dialog.dart';

class GiftsViewBody extends StatefulWidget {
  final int? studentId;
  final int? secretaryId;

  const GiftsViewBody({
    Key? key,
    this.studentId,
    this.secretaryId,
  })  : assert(
  (studentId == null) ^ (secretaryId == null),
  'Provide exactly one of studentId or secretaryId',
  ),
        super(key: key);

  @override
  _GiftsViewBodyState createState() => _GiftsViewBodyState();
}

class _GiftsViewBodyState extends State<GiftsViewBody> {
  final _scrollController = ScrollController();
  bool _loadingMore = false;
  int _currentPage = 1, _lastPage = 1;

  bool get _isStudent => widget.studentId != null;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200 &&
        !_loadingMore &&
        _currentPage < _lastPage) {
      _loadingMore = true;
      _reload(page: _currentPage + 1);
    }
  }

  void _reload({int page = 1}) {
    final cubit = context.read<GiftsCubit>();
    if (_isStudent) {
      cubit.fetchForStudent(widget.studentId!, page: page);
    } else {
      cubit.fetchForSecretary(widget.secretaryId!, page: page);
    }
  }

  Future<void> _showForm(BuildContext ctx, [Gift? existing]) async {
    final created = await showDialog<bool>(
      context: ctx,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: ctx.read<CreateGiftCubit>()),
          BlocProvider.value(value: ctx.read<UpdateGiftCubit>()),
        ],
        child: GiftFormDialog(
          studentId: widget.studentId,
          secretaryId: widget.secretaryId,
          existing: existing,
        ),
      ),
    );
    if (created == true) _reload();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final crossAxisCount = ((screenW - 210) / 250).floor().clamp(2, 10);

    return MultiBlocListener(
      listeners: [
        BlocListener<CreateGiftCubit, CreateGiftState>(
          listener: (ctx, s) {
            if (s is CreateGiftFailure) {
              CustomSnackBar.showErrorSnackBar(ctx, msg: s.error);
            } else if (s is CreateGiftSuccess) {
              CustomSnackBar.showSnackBar(ctx, msg: 'Award created');
              _reload(page: 1);
            }
          },
        ),
        BlocListener<UpdateGiftCubit, UpdateGiftState>(
          listener: (ctx, s) {
            if (s is UpdateGiftFailure) {
              CustomSnackBar.showErrorSnackBar(ctx, msg: s.error);
            } else if (s is UpdateGiftSuccess) {
              CustomSnackBar.showSnackBar(ctx, msg: 'Award updated');
              _reload(page: 1);
            }
          },
        ),
        BlocListener<DeleteGiftCubit, DeleteGiftState>(
          listener: (ctx, s) {
            if (s is DeleteGiftFailure) {
              CustomSnackBar.showErrorSnackBar(ctx, msg: s.error);
            } else if (s is DeleteGiftSuccess) {
              CustomSnackBar.showSnackBar(ctx, msg: 'Award deleted');
              _reload(page: 1);
            }
          },
        ),
        BlocListener<GiftsCubit, GiftsState>(
          listener: (ctx, state) {
            if (state is GiftsSuccess) {
              _currentPage = state.currentPage;
              _lastPage = state.lastPage;
              _loadingMore = false;
            }
          },
        ),
      ],
      child: BlocBuilder<GiftsCubit, GiftsState>(
        builder: (ctx, state) {
          if (state is GiftsLoading) {
            return const Center(child: CustomCircularProgressIndicator());
          }
          if (state is GiftsFailure) {
            return CustomErrorWidget(errorMessage: state.error);
          }

          final gifts = (state as GiftsSuccess).gifts;

          return Padding(
            padding: EdgeInsets.only(top: 56.h),
            child: CustomScreenBody(
              title: 'Awards',
              showSearchField: false,onPressedFirst: (){},
              showFirstButton: false,
              showSecondButton: true,
              textSecondButton: 'Add Award',
              onPressedSecond: () => _showForm(ctx),
              body: Padding(
                padding: EdgeInsets.only(
                  top: 238.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 27.h,
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      if (gifts.isEmpty)
                        const CustomEmptyWidget(
                          firstText: 'No awards to display.',
                          secondText: 'You’ll see awards here once you add them.',
                        )
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: gifts.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 280,
                          ),
                          itemBuilder: (c, i) {
                            final g = gifts[i];
                            return CustomCard(
                              image: g.photo,onTap:(){},
                              text: g.description,
                              showSecondDetailsText: true,
                              secondDetailsText:
                              DateFormat.yMMMd().format(g.date),
                              showIcons: true,
                              onTapFirstIcon: () => _showForm(c, g),
                              onTapSecondIcon: () async {
                                final confirmed = await showDialog<bool>(
                                  context: c,
                                  builder: (dCtx) => AlertDialog(
                                    title: const Text('Confirm delete'),
                                    content: const Text(
                                        'Are you sure you want to delete this award?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(dCtx).pop(false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(dCtx).pop(true),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirmed == true) {
                                  c.read<DeleteGiftCubit>().deleteGift(g.id);
                                }
                              },
                            );
                          },
                        ),

                      if (_loadingMore)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const CustomCircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
