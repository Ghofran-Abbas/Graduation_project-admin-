import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../department/presentation/manager/details_department_cubit/details_department_cubit.dart';
import '../../../../department/presentation/manager/details_department_cubit/details_department_state.dart';
import '../../manager/courses_cubit/courses_cubit.dart';
import '../../manager/courses_cubit/courses_state.dart';
import '../../manager/create_course_cubit/create_course_cubit.dart';
import '../../manager/create_course_cubit/create_course_state.dart';
import '../../manager/delete_course_cubit/delete_course_cubit.dart';
import '../../manager/delete_course_cubit/delete_course_state.dart';
import '../../manager/update_course_cubit/update_course_cubit.dart';
import '../../manager/update_course_cubit/update_course_state.dart';

class CoursesViewBody extends StatefulWidget {
  const CoursesViewBody({super.key, required this.depId});

  final int depId;

  @override
  State<CoursesViewBody> createState() => _CoursesViewBodyState();
}

class _CoursesViewBodyState extends State<CoursesViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  Uint8List? selectedImage;


  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          selectedImage = result.files.single.bytes!;
        });
      } else {
        CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('No image selected or image data is unavailable.'),);
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, msg: '${AppLocalizations.of(context).translate('Failed to pick image:')} $e',);
    }
  }

  void register() {
    if (_formKey.currentState!.validate() && selectedImage != null) {
      context.read<CreateCourseCubit>().fetchCreateCourse(
        departmentId: widget.depId,
        name: nameController.text,
        description: descriptionController.text,
        photo: selectedImage!,
      );
    } else {
      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('Error, Please enter all the fields.'),);
    }
  }

  void update(int id) {
    context.read<UpdateCourseCubit>().fetchUpdateCourse(
      id: id,
      departmentId: widget.depId,
      name: nameController.text,
      description: descriptionController.text,
      photo: selectedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return BlocConsumer<CreateCourseCubit, CreateCourseState>(
      listener: (context, state) {
        if (state is CreateCourseFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('CreateCourseFailure'),);
        } else if (state is CreateCourseSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('CreateCourseSuccess'),);
        } else if (state is ImagePickedSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('ImagePickedSuccess'),);
        }
      },
      builder: (context, state) {
        return BlocConsumer<UpdateCourseCubit, UpdateCourseState>(
          listener: (context, state) {
            if (state is UpdateCourseFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateCourseFailure'),);
            } else if (state is UpdateCourseSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateCourseSuccess'),);
            } else if (state is ImagePickedSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('ImagePickedSuccess'),);
            }
          },
          builder: (context, state) {
            return BlocConsumer<DeleteCourseCubit, DeleteCourseState>(
              listener: (context, state) {
                if (state is DeleteCourseFailure) {
                  CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteCourseFailure'),);
                } else if (state is DeleteCourseSuccess) {
                  CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteCourseSuccess'),);
                }
              },
              builder: (context, state) {
                return BlocConsumer<CoursesCubit,CoursesState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return BlocConsumer<DetailsDepartmentCubit, DetailsDepartmentState>(
                      listener: (contextD, stateD) {},
                      builder: (contextD, stateD) {
                        if(stateD is DetailsDepartmentSuccess) {
                          if(state is CoursesSuccess) {
                            return Padding(
                              padding: EdgeInsets.only(top: 56.0.h,),
                              child: CustomScreenBody(
                                title: stateD.showResult.department.name,
                                showSearchField: true,
                                onPressedFirst: () {},
                                onPressedSecond: () {},
                                onTapSearch: () {
                                  if(state.courses.courses!.isNotEmpty) {
                                    context.go('${GoRouterPath.courses}/${state.courses.courses![0].departmentId}${GoRouterPath.searchCourse}');
                                  }
                                },
                                body: Padding(
                                  padding: EdgeInsets.only(
                                      top: 238.0.h,
                                      left: 47.0.w,
                                      right: 47.0.w,
                                      bottom: 27.0.h),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 40.h, right: 47.0.w,),
                                    child: DefaultTabController(
                                      length: 3,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 70.h,
                                            child: TabBar(
                                              labelColor: AppColors
                                                  .blue,
                                              unselectedLabelColor: AppColors
                                                  .blue,
                                              indicator: BoxDecoration(
                                                shape: BoxShape
                                                    .circle,
                                                color: AppColors
                                                    .darkBlue,
                                              ),
                                              indicatorPadding: EdgeInsets
                                                  .only(
                                                  top: 48.r,
                                                  bottom: 12.r),
                                              indicatorWeight: 20,
                                              labelStyle: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight
                                                      .bold),
                                              unselectedLabelStyle: TextStyle(
                                                  fontWeight: FontWeight
                                                      .normal),
                                              tabs: [
                                                Tab(text: AppLocalizations.of(context).translate('         Active         '),),
                                                Tab(text: AppLocalizations.of(context).translate('In preparation')),
                                                Tab(text: AppLocalizations.of(context).translate('        Complete        '),),

                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 592.23.h,
                                            child: TabBarView(
                                              children: [
                                                SingleChildScrollView(
                                                  physics: BouncingScrollPhysics(),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      state.courses.courses!.isNotEmpty ? GridView.builder(
                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                                                        itemBuilder: (BuildContext context, int index) {
                                                          return Align(child: CustomCard(
                                                            image: state.courses.courses![index].photo,
                                                            text: state.courses.courses![index].name,
                                                            onTap: () {
                                                              context.go('${GoRouterPath.courses}/${stateD.showResult.department.id}${GoRouterPath.courseDetails}/${state.courses.courses![index].id}');
                                                            },
                                                            onTapFirstIcon: () {},
                                                            onTapSecondIcon: (){},
                                                          ));
                                                        },
                                                        itemCount: state.courses.courses!.length,
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                      ) : CustomEmptyWidget(
                                                        firstText: AppLocalizations.of(context).translate('No active courses at this time'),
                                                        secondText: AppLocalizations.of(context).translate('Courses will appear here after they enroll in your institute.'),
                                                      ),
                                                      /*ustomNumberPagination(
                                                        numberPages: state.courses.courses.lastPage,
                                                        initialPage: state.courses.courses.currentPage,
                                                        onPageChange: (int index) {
                                                          context.read<CoursesCubit>().fetchCourses(page: index + 1);
                                                        },
                                                      ),*/
                                                    ],
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  physics: BouncingScrollPhysics(),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GridView.builder(
                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                                                        itemBuilder: (BuildContext context, int index) {
                                                          return Align(child: CustomCard(
                                                            text: 'Video Editing',
                                                            detailsText: 'Section 1',
                                                            secondDetailsText: 'Media & Pro',
                                                            showDetailsText: true,
                                                            onTap: (){context.go('${GoRouterPath.inPreparationDetails}/1');},
                                                            onTapFirstIcon: (){},
                                                            onTapSecondIcon: (){},
                                                          ));
                                                        },
                                                        itemCount: 20,
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  physics: BouncingScrollPhysics(),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GridView.builder(
                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                                                        itemBuilder: (BuildContext context, int index) {
                                                          return Align(child: CustomCard(
                                                            text: 'Video Editing',
                                                            detailsText: 'Section 1',
                                                            secondDetailsText: 'Media & Pro',
                                                            showDetailsText: true,
                                                            showRating: true,
                                                            showCheckEndCourse: true,
                                                            ratingText: '2.8',
                                                            ratingIcon: Icons.star,
                                                            onTap: (){context.go('${GoRouterPath.completeDetails}/1');},
                                                            onTapFirstIcon: (){},
                                                            onTapSecondIcon: (){},
                                                          ));
                                                        },
                                                        itemCount: 20,
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if(state is CoursesFailure) {
                            return CustomErrorWidget(errorMessage: state.errorMessage);
                          } else {
                            return CustomCircularProgressIndicator();
                          }
                        } else if(stateD is DetailsDepartmentFailure) {
                          return CustomErrorWidget(errorMessage: stateD.errorMessage);
                        } else {
                          return CustomCircularProgressIndicator();
                        }
                      }
                    );
                  }
                );
              }
            );
          }
        );
      }
    );
  }
}
