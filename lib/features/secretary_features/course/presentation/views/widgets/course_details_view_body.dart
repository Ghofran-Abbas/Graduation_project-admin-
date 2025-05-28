import 'dart:developer';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_dropdown_list.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_multiple_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../data/models/sections_model.dart';
import '../../manager/create_section_cubit/create_section_cubit.dart';
import '../../manager/create_section_cubit/create_section_state.dart';
import '../../manager/delete_section_cubit/delete_section_cubit.dart';
import '../../manager/delete_section_cubit/delete_section_state.dart';
import '../../manager/details_course_cubit/details_course_cubit.dart';
import '../../manager/details_course_cubit/details_course_state.dart';
import '../../manager/sections_cubit/sections_cubit.dart';
import '../../manager/sections_cubit/sections_state.dart';
import '../../manager/students_section_cubit/students_section_cubit.dart';
import '../../manager/students_section_cubit/students_section_state.dart';
import '../../manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../manager/trainers_section_cubit/trainers_section_state.dart';
import '../../manager/update_section_cubit/update_section_cubit.dart';
import '../../manager/update_section_cubit/update_section_state.dart';


class CourseDetailsViewBody extends StatefulWidget {

  CourseDetailsViewBody({super.key});

  @override
  State<CourseDetailsViewBody> createState() => _CourseDetailsViewBodyState();
}

class _CourseDetailsViewBodyState extends State<CourseDetailsViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController startDateController;
  late final TextEditingController endDateController;
  late final TextEditingController descriptionController;
  Uint8List? selectedImage;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    nameController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    startDateController.dispose();
    endDateController.dispose();
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

  /*void register() {
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
  }*/

  @override
  Widget build(BuildContext context) {
    bool? showSecondButton;
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    int count = 10;
    return BlocConsumer<DetailsCourseCubit, DetailsCourseState>(
        listener: (contextDC, stateDC) {},
        builder: (contextDC, stateDC) {
          if(stateDC is DetailsCourseSuccess) {
            return BlocConsumer<SectionsCubit, SectionsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is SectionsSuccess) {
                    final List<DatumSection> sections = state.createResult.data!;
                    return Padding(
                      padding: EdgeInsets.only(top: 56.0.h,),
                      child: CustomScreenBody(
                        title: stateDC.course.course.name,
                        textFirstButton: 'Section 2',
                        showFirstButton: true,
                        widget: BlocBuilder<SelectSectionCubit, SelectSectionState>(
                          builder: (context, selectState) {
                            DatumSection? selected;
                            if (selectState is SelectSectionSuccess) {
                              selected = selectState.section;
                              showSecondButton = true;
                            }
                            return Padding(
                              padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
                              child: DropdownMenu<DatumSection>(
                                enableSearch: false,
                                requestFocusOnTap: false,
                                width: 200.w,
                                hintText: AppLocalizations.of(context).translate('No section'),
                                initialSelection: selected,
                                inputDecorationTheme: InputDecorationTheme(
                                  constraints: BoxConstraints(
                                      maxHeight: 53.h),
                                  hintStyle: Styles.l1Normal(
                                      color: AppColors.t0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.purple,
                                      width: 1.23,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        24.67.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.purple,
                                      width: 1.23,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        24.67.r),
                                  ),
                                ),
                                alignmentOffset: Offset(4, 2),
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStateColor
                                      .resolveWith(
                                        (states) {
                                      return AppColors.white;
                                    },
                                  ),
                                  elevation: WidgetStateProperty.resolveWith(
                                        (states) {
                                      return 0;
                                    },
                                  ),
                                  side: WidgetStateBorderSide.resolveWith(
                                        (states) {
                                      return BorderSide(
                                        width: 1.23,
                                        color: AppColors.purple,

                                      );
                                    },
                                  ),

                                ),
                                dropdownMenuEntries: sections.map((section) {
                                  return DropdownMenuEntry<DatumSection>(
                                    value: section,
                                    label: section.name,
                                  );
                                }).toList(),
                                onSelected: (DatumSection? selectedSection) {
                                  if (selectedSection != null) {
                                    BlocProvider.of<SelectSectionCubit>(
                                        context).selectSection(
                                        section: selectedSection);
                                    log('✅ Selected ID: ${selectedSection
                                        .id}');
                                  }
                                },
                              ),
                            );
                          },
                        ),
                        onPressedFirst: () {},
                        showButtonIcon: true,
                        textSecondButton: AppLocalizations.of(context).translate('New announcement'),
                        showSecondButton: true,
                        onPressedSecond: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setStateDialog) {
                                    return Form(
                                      key: _formKey,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            width: 871.w,
                                            height: 788.h,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 160.w,
                                                vertical: 115.h),
                                            padding: EdgeInsets.all(22.r),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.circular(
                                                  6.r),
                                            ),
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 65.h,
                                                        left: 60.w,
                                                        right: 155.w),
                                                    child: Text(
                                                      AppLocalizations.of(context).translate('Add announcement'),
                                                      style: Styles.h3Bold(
                                                          color: AppColors.t3),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 60.w),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Stack(
                                                                    children: [
                                                                      selectedImage !=
                                                                          null
                                                                          ? CustomMemoryImage(
                                                                        image: selectedImage,
                                                                        imageWidth: 186
                                                                            .w,
                                                                        imageHeight: 186
                                                                            .w,
                                                                        borderRadius: 150
                                                                            .r,
                                                                      )
                                                                          : CustomImageAsset(
                                                                        imageWidth: 186
                                                                            .w,
                                                                        imageHeight: 186
                                                                            .w,
                                                                        borderRadius: 150
                                                                            .r,
                                                                      ),
                                                                      Positioned(
                                                                        top: 140.w,
                                                                        left: 150.w,
                                                                        child: CustomIconButton(
                                                                          icon: Icons
                                                                              .add,
                                                                          onTap: () async {
                                                                            await pickImage();
                                                                            setStateDialog(() {});
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 65.w),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex: 1,
                                                                          child: CustomLabelTextFormField(
                                                                            hintText: AppLocalizations.of(context).translate('Start date'),
                                                                            readOnly: true,
                                                                            controller: startDateController,
                                                                            topPadding: 65.h,
                                                                            leftPadding: 0.w,
                                                                            rightPadding: 0.w,
                                                                            bottomPadding: 33.h,
                                                                            onTap: () async {
                                                                              DateTime? pickedDate = await showDatePicker(
                                                                                context: context,
                                                                                initialDate: startDateController.text.isEmpty ? DateTime.now() : DateTime.parse(startDateController.text),
                                                                                firstDate: DateTime(2000),
                                                                                lastDate: DateTime(2100),
                                                                              );
                                                                              if (pickedDate != null) {
                                                                                startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
                                                                                endDateController.clear();
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 19.w,),
                                                                        Expanded(
                                                                          flex: 1,
                                                                          child: CustomLabelTextFormField(
                                                                            hintText: AppLocalizations.of(context).translate('End date'),
                                                                            readOnly: true,
                                                                            controller: endDateController,
                                                                            topPadding: 65.h,
                                                                            leftPadding: 0.w,
                                                                            rightPadding: 0.w,
                                                                            bottomPadding: 38.h,
                                                                            onTap: () async {
                                                                              if (startDateController.text.isEmpty) {
                                                                                CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('SelectEndDateFailure'),);
                                                                                return;
                                                                              }

                                                                              DateTime parsedStartDate = DateTime.parse(startDateController.text);
                                                                              DateTime initialEndDate = parsedStartDate.add(Duration(days: 1));

                                                                              DateTime? pickedDate = await showDatePicker(
                                                                                context: context,
                                                                                initialDate: endDateController.text.isEmpty
                                                                                    ? initialEndDate
                                                                                    : DateTime.parse(endDateController.text),
                                                                                firstDate: initialEndDate,
                                                                                lastDate: DateTime(2100),
                                                                              );

                                                                              if (pickedDate != null) {
                                                                                endDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  CustomLabelTextFormField(
                                                                    labelText: AppLocalizations.of(context).translate('Description'),
                                                                    showLabelText: true,
                                                                    controller: descriptionController,
                                                                    boxHeight: 327.h,
                                                                    maxLines: 11,
                                                                    topPadding: 35.h,
                                                                    bottomPadding: 0.h,
                                                                    leftPadding: 0.w,
                                                                    rightPadding: 128
                                                                        .w,
                                                                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        CustomLabelTextFormField(
                                                          labelText: AppLocalizations.of(context).translate('Title'),
                                                          showLabelText: true,
                                                          controller: nameController,
                                                          topPadding: 0.h,
                                                          bottomPadding: 0.h,
                                                          leftPadding: 0.w,
                                                          rightPadding: 128.w,
                                                          validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 60.h,
                                                        bottom: 65.h,
                                                        left: 47.w,
                                                        right: 155.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        TextIconButton(
                                                          textButton: AppLocalizations.of(context).translate('Add announcement'),
                                                          bigText: true,
                                                          textColor: AppColors.t3,
                                                          icon: Icons.add,
                                                          iconSize: 40.01.r,
                                                          iconColor: AppColors.t2,
                                                          iconLast: false,
                                                          firstSpaceBetween: 3.w,
                                                          buttonHeight: 53.h,
                                                          borderWidth: 0.w,
                                                          buttonColor: AppColors
                                                              .white,
                                                          borderColor: Colors
                                                              .transparent,
                                                          onPressed: () {
                                                            //register();
                                                            nameController
                                                                .clear();
                                                            descriptionController
                                                                .clear();
                                                            Navigator.pop(
                                                                dialogContext);
                                                          },
                                                        ),
                                                        SizedBox(width: 42.w,),
                                                        TextIconButton(
                                                          textButton: AppLocalizations.of(context).translate('       Cancel       '),
                                                          textColor: AppColors.t3,
                                                          iconLast: false,
                                                          buttonHeight: 53.h,
                                                          borderWidth: 0.w,
                                                          borderRadius: 4.r,
                                                          buttonColor: AppColors
                                                              .w1,
                                                          borderColor: AppColors
                                                              .w1,
                                                          onPressed: () {
                                                            nameController
                                                                .clear();
                                                            descriptionController
                                                                .clear();
                                                            Navigator.pop(
                                                                dialogContext);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              );
                            },
                          );
                        },
                        body: BlocBuilder<SelectSectionCubit, SelectSectionState>(
                            builder: (contextSec, stateSec) {
                              if (stateSec is SelectSectionSuccess) {
                                TrainersSectionCubit.get(context).fetchTrainersSection(id: stateSec.section.id, page: 1);
                                StudentsSectionCubit.get(context).fetchStudentsSection(id: stateSec.section.id, page: 1);
                                return BlocConsumer<TrainersSectionCubit, TrainersSectionState>(
                                    listener: (contextTS, stateTS) {},
                                    builder: (contextTS, stateTS) {
                                      return BlocBuilder<StudentsSectionCubit, StudentsSectionState>(
                                        builder: (contextSS, stateSS) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 238.0.h,
                                                left: 77.0.w,
                                                bottom: 27.0.h),
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      CustomCourseInformation(
                                                        image: stateDC.course.course.photo,
                                                        showSectionInformation: true,
                                                        ratingText: '4.9',
                                                        ratingPercent: 0.5,
                                                        ratingPercentText: '50%',
                                                        circleStatusColor: AppColors.mintGreen,
                                                        courseStatusText: handleReciveState(state: stateSec.section.state),
                                                        startDateText: stateSec.section.startDate.toString().replaceRange(10, 23, ''),
                                                        showCourseCalenderIcon: true,
                                                        endDateText: stateSec.section.endDate.toString().replaceRange(10, 23, ''),
                                                        numberSeatsText: '${stateSec.section.seatsOfNumber} ${AppLocalizations.of(context).translate('Seats')}',
                                                        bodyText: stateDC.course.course.description,
                                                        onTap: () {},
                                                        onTapDate: () {
                                                          context.go(
                                                              '${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.calendar}/${stateSec.section.id}');
                                                        },
                                                        onTapFirstIcon: () {},
                                                        onTapSecondIcon: () {},
                                                      ),
                                                      SizedBox(height: 22.h),
                                                      Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          BlocBuilder<StudentsSectionCubit, StudentsSectionState>(
                                                              builder: (contextSS, stateSS) {
                                                                if(stateSS is StudentsSectionSuccess) {
                                                                  return Row(
                                                                    children: [
                                                                      CustomOverloadingAvatar(
                                                                        labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateSS.students.students.data![0].students!.length} ${AppLocalizations.of(context).translate('students in this class')}',
                                                                        tailText: AppLocalizations.of(context).translate('See more'),
                                                                        firstImage: stateSS.students.students.data![0].students!.isNotEmpty ? stateSS.students.students.data![0].students![0].photo : '',
                                                                        secondImage: stateSS.students.students.data![0].students!.length >= 2 ? stateSS.students.students.data![0].students![1].photo : '',
                                                                        thirdImage: stateSS.students.students.data![0].students!.length >= 3 ? stateSS.students.students.data![0].students![2].photo : '',
                                                                        fourthImage: stateSS.students.students.data![0].students!.length >= 4 ? stateSS.students.students.data![0].students![3].photo : '',
                                                                        fifthImage: stateSS.students.students.data![0].students!.length >= 5 ? stateSS.students.students.data![0].students![4].photo : '',
                                                                        avatarCount: stateSS.students.students.data![0].students!.length,
                                                                        onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        width: calculateWidthBetweenAvatars(avatarCount: stateSS.students.students.data![0].students!.length) /*270.w*/,),
                                                                    ],
                                                                  );
                                                                } else if(stateSS is StudentsSectionFailure) {
                                                                  return Row(
                                                                    children: [
                                                                      CustomOverloadingAvatar(
                                                                        labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('students in this class')}',
                                                                        tailText: AppLocalizations.of(context).translate('See more'),
                                                                        firstImage: '',
                                                                        secondImage: '',
                                                                        thirdImage: '',
                                                                        fourthImage: '',
                                                                        fifthImage: '',
                                                                        avatarCount: 5,
                                                                        onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        width: calculateWidthBetweenAvatars(avatarCount: 5) /*270.w*/,),
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return CustomCircularProgressIndicator();
                                                                }
                                                              }
                                                          ),
                                                          BlocBuilder<TrainersSectionCubit, TrainersSectionState>(
                                                              builder: (contextTS, stateTS) {
                                                                if(stateTS is TrainersSectionSuccess) {
                                                                  return CustomOverloadingAvatar(
                                                                    labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateTS.trainers.trainers![0].trainers!.length} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                                                    tailText: AppLocalizations.of(context).translate('See more'),
                                                                    firstImage: stateTS.trainers.trainers![0].trainers!.isNotEmpty ? stateTS.trainers.trainers![0].trainers![0].photo : '',
                                                                    secondImage: stateTS.trainers.trainers![0].trainers!.length >= 2 ? stateTS.trainers.trainers![0].trainers![1].photo : '',
                                                                    thirdImage: stateTS.trainers.trainers![0].trainers!.length >= 3 ? stateTS.trainers.trainers![0].trainers![2].photo : '',
                                                                    fourthImage: stateTS.trainers.trainers![0].trainers!.length >= 4 ? stateTS.trainers.trainers![0].trainers![3].photo : '',
                                                                    fifthImage: stateTS.trainers.trainers![0].trainers!.length >= 5 ? stateTS.trainers.trainers![0].trainers![4].photo : '',
                                                                    avatarCount: stateTS.trainers.trainers![0].trainers!.length,
                                                                    onTap: () {
                                                                      context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionTrainers}/${stateSec.section.id}');
                                                                    },
                                                                  );
                                                                } else if(stateTS is TrainersSectionFailure) {
                                                                  return CustomOverloadingAvatar(
                                                                    labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                                                    tailText: AppLocalizations.of(context).translate('See more'),
                                                                    firstImage: '',
                                                                    secondImage: '',
                                                                    thirdImage: '',
                                                                    fourthImage: '',
                                                                    fifthImage: '',
                                                                    avatarCount: 5,
                                                                    onTap: () {
                                                                      context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionTrainers}/${stateSec.section.id}');
                                                                    },
                                                                  );
                                                                } else {
                                                                  return CustomCircularProgressIndicator();
                                                                }
                                                              }
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                          top: 40.h, right: 47.0.w,),
                                                        child: DefaultTabController(
                                                          length: 2,
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
                                                                    Tab(
                                                                      text: AppLocalizations.of(context).translate('         File         '),),
                                                                    Tab(text: AppLocalizations.of(context).translate('Announcement')),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 470.23.h,
                                                                child: TabBarView(
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        GridViewFiles(
                                                                          fileName: 'hgjhv',
                                                                          cardCount: 5,
                                                                        ),
                                                                        NumberPaginator(
                                                                          numberPages: 2,
                                                                          onPageChange: (
                                                                              int index) {},
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    CustomOverLoadingCard(
                                                                      cardCount: count,
                                                                      onTapSeeMore: () {
                                                                        context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.announcementsA}/1');
                                                                      },
                                                                      widget: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          return Align(
                                                                            child: CustomCard(
                                                                              text: 'Discount 30%',
                                                                              showIcons: true,
                                                                              onTap: () {
                                                                                context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/1${GoRouterPath.announcementsA}/1${GoRouterPath.announcementADetails}/1');
                                                                                //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.announcements}/1');
                                                                              },
                                                                              onTapFirstIcon: () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext dialogContext) {
                                                                                    return StatefulBuilder(
                                                                                        builder: (BuildContext context,
                                                                                            void Function(void Function()) setStateDialog) {
                                                                                          return Form(
                                                                                            key: _formKey,
                                                                                            child: Align(
                                                                                              alignment: Alignment.topRight,
                                                                                              child: Material(
                                                                                                color: Colors.transparent,
                                                                                                child: Container(
                                                                                                  width: 871.w,
                                                                                                  height: 788.h,
                                                                                                  margin: EdgeInsets.symmetric(
                                                                                                      horizontal: 160.w,
                                                                                                      vertical: 115.h),
                                                                                                  padding: EdgeInsets.all(22.r),
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: AppColors.white,
                                                                                                    borderRadius: BorderRadius.circular(
                                                                                                        6.r),
                                                                                                  ),
                                                                                                  child: SingleChildScrollView(
                                                                                                    physics: BouncingScrollPhysics(),
                                                                                                    child: Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                                          .start,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.only(
                                                                                                              top: 65.h,
                                                                                                              left: 60.w,
                                                                                                              right: 155.w),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(context).translate('Edit announcement'),
                                                                                                            style: Styles.h3Bold(
                                                                                                                color: AppColors.t3),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.only(
                                                                                                              left: 60.w),
                                                                                                          child: Column(
                                                                                                            children: [
                                                                                                              Row(
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Expanded(
                                                                                                                    child: Column(
                                                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                                                          .start,
                                                                                                                      children: [
                                                                                                                        Stack(
                                                                                                                          children: [
                                                                                                                            selectedImage !=
                                                                                                                                null
                                                                                                                                ? CustomMemoryImage(
                                                                                                                              image: selectedImage,
                                                                                                                              imageWidth: 186
                                                                                                                                  .w,
                                                                                                                              imageHeight: 186
                                                                                                                                  .w,
                                                                                                                              borderRadius: 150
                                                                                                                                  .r,
                                                                                                                            )
                                                                                                                                : CustomImageAsset(
                                                                                                                              imageWidth: 186
                                                                                                                                  .w,
                                                                                                                              imageHeight: 186
                                                                                                                                  .w,
                                                                                                                              borderRadius: 150
                                                                                                                                  .r,
                                                                                                                            ),
                                                                                                                            Positioned(
                                                                                                                              top: 140.w,
                                                                                                                              left: 150.w,
                                                                                                                              child: CustomIconButton(
                                                                                                                                icon: Icons
                                                                                                                                    .add,
                                                                                                                                onTap: () async {
                                                                                                                                  await pickImage();
                                                                                                                                  setStateDialog(() {});
                                                                                                                                },
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                        Padding(
                                                                                                                          padding: EdgeInsets.only(right: 65.w),
                                                                                                                          child: Row(
                                                                                                                            children: [
                                                                                                                              Expanded(
                                                                                                                                flex: 1,
                                                                                                                                child: CustomLabelTextFormField(
                                                                                                                                  hintText: AppLocalizations.of(context).translate('Start date'),
                                                                                                                                  readOnly: true,
                                                                                                                                  controller: startDateController,
                                                                                                                                  topPadding: 65.h,
                                                                                                                                  leftPadding: 0.w,
                                                                                                                                  rightPadding: 0.w,
                                                                                                                                  bottomPadding: 33.h,
                                                                                                                                  onTap: () async {
                                                                                                                                    DateTime? pickedDate = await showDatePicker(
                                                                                                                                      context: context,
                                                                                                                                      initialDate: startDateController.text.isEmpty ? DateTime.now() : DateTime.parse(startDateController.text),
                                                                                                                                      firstDate: DateTime(2000),
                                                                                                                                      lastDate: DateTime(2100),
                                                                                                                                    );
                                                                                                                                    if (pickedDate != null) {
                                                                                                                                      startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
                                                                                                                                      endDateController.clear();
                                                                                                                                    }
                                                                                                                                  },
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              SizedBox(width: 19.w,),
                                                                                                                              Expanded(
                                                                                                                                flex: 1,
                                                                                                                                child: CustomLabelTextFormField(
                                                                                                                                  hintText: AppLocalizations.of(context).translate('End date'),
                                                                                                                                  readOnly: true,
                                                                                                                                  controller: endDateController,
                                                                                                                                  topPadding: 65.h,
                                                                                                                                  leftPadding: 0.w,
                                                                                                                                  rightPadding: 0.w,
                                                                                                                                  bottomPadding: 38.h,
                                                                                                                                  onTap: () async {
                                                                                                                                    if (startDateController.text.isEmpty) {
                                                                                                                                      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('SelectEndDateFailure'),);
                                                                                                                                      return;
                                                                                                                                    }

                                                                                                                                    DateTime parsedStartDate = DateTime.parse(startDateController.text);
                                                                                                                                    DateTime initialEndDate = parsedStartDate.add(Duration(days: 1));

                                                                                                                                    DateTime? pickedDate = await showDatePicker(
                                                                                                                                      context: context,
                                                                                                                                      initialDate: endDateController.text.isEmpty
                                                                                                                                          ? initialEndDate
                                                                                                                                          : DateTime.parse(endDateController.text),
                                                                                                                                      firstDate: initialEndDate,
                                                                                                                                      lastDate: DateTime(2100),
                                                                                                                                    );

                                                                                                                                    if (pickedDate != null) {
                                                                                                                                      endDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
                                                                                                                                    }
                                                                                                                                  },
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Expanded(
                                                                                                                    child: Column(
                                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                      children: [
                                                                                                                        CustomLabelTextFormField(
                                                                                                                          labelText: AppLocalizations.of(context).translate('Description'),
                                                                                                                          showLabelText: true,
                                                                                                                          controller: descriptionController,
                                                                                                                          boxHeight: 327.h,
                                                                                                                          maxLines: 11,
                                                                                                                          topPadding: 35.h,
                                                                                                                          bottomPadding: 0.h,
                                                                                                                          leftPadding: 0.w,
                                                                                                                          rightPadding: 128
                                                                                                                              .w,
                                                                                                                          validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                                                                                        ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                              CustomLabelTextFormField(
                                                                                                                labelText: AppLocalizations.of(context).translate('Title'),
                                                                                                                showLabelText: true,
                                                                                                                controller: nameController,
                                                                                                                topPadding: 0.h,
                                                                                                                bottomPadding: 0.h,
                                                                                                                leftPadding: 0.w,
                                                                                                                rightPadding: 128.w,
                                                                                                                validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.only(
                                                                                                              top: 60.h,
                                                                                                              bottom: 65.h,
                                                                                                              left: 47.w,
                                                                                                              right: 155.w),
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment
                                                                                                                .start,
                                                                                                            children: [
                                                                                                              TextIconButton(
                                                                                                                textButton: AppLocalizations.of(context).translate('Edit announcement'),
                                                                                                                bigText: true,
                                                                                                                textColor: AppColors.t3,
                                                                                                                icon: Icons.add,
                                                                                                                iconSize: 40.01.r,
                                                                                                                iconColor: AppColors.t2,
                                                                                                                iconLast: false,
                                                                                                                firstSpaceBetween: 3.w,
                                                                                                                buttonHeight: 53.h,
                                                                                                                borderWidth: 0.w,
                                                                                                                buttonColor: AppColors
                                                                                                                    .white,
                                                                                                                borderColor: Colors
                                                                                                                    .transparent,
                                                                                                                onPressed: () {
                                                                                                                  //register();
                                                                                                                  nameController
                                                                                                                      .clear();
                                                                                                                  descriptionController
                                                                                                                      .clear();
                                                                                                                  Navigator.pop(
                                                                                                                      dialogContext);
                                                                                                                },
                                                                                                              ),
                                                                                                              SizedBox(width: 42.w,),
                                                                                                              TextIconButton(
                                                                                                                textButton: AppLocalizations.of(context).translate('       Cancel       '),
                                                                                                                textColor: AppColors.t3,
                                                                                                                iconLast: false,
                                                                                                                buttonHeight: 53.h,
                                                                                                                borderWidth: 0.w,
                                                                                                                borderRadius: 4.r,
                                                                                                                buttonColor: AppColors
                                                                                                                    .w1,
                                                                                                                borderColor: AppColors
                                                                                                                    .w1,
                                                                                                                onPressed: () {
                                                                                                                  nameController
                                                                                                                      .clear();
                                                                                                                  descriptionController
                                                                                                                      .clear();
                                                                                                                  Navigator.pop(
                                                                                                                      dialogContext);
                                                                                                                },
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                              onTapSecondIcon: () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext dialogContext) {
                                                                                    return Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: Material(
                                                                                        color: Colors.transparent,
                                                                                        child: Container(
                                                                                          width: 638.w,
                                                                                          height: 478.h,
                                                                                          margin: EdgeInsets.symmetric(horizontal: 280.w, vertical: 255.h),
                                                                                          padding:  EdgeInsets.all(22.r),
                                                                                          decoration: BoxDecoration(
                                                                                            color: AppColors.white,
                                                                                            borderRadius: BorderRadius.circular(6.r),
                                                                                          ),
                                                                                          child: SingleChildScrollView(
                                                                                            physics: BouncingScrollPhysics(),
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsets.only(top: 65.h, left: 30.w, right: 155.w),
                                                                                                  child: Row(
                                                                                                    children: [
                                                                                                      Icon(
                                                                                                        Icons.error_outline,
                                                                                                        color: AppColors.orange,
                                                                                                        size: 55.r,
                                                                                                      ),
                                                                                                      SizedBox(width: 10.w,),
                                                                                                      Text(
                                                                                                        AppLocalizations.of(context).translate('Warning'),
                                                                                                        style: Styles.h3Bold(color: AppColors.t3),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsets.only(top: 75.h, left: 65.w, right: 155.w),
                                                                                                  child: Text(
                                                                                                    AppLocalizations.of(context).translate('Are you sure you want to delete this announcement?'),
                                                                                                    style: Styles.b2Normal(color: AppColors.t3),
                                                                                                    maxLines: 1,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsets.only(top: 90.h, bottom: 65.h, left: 47.w, right: 155.w),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    children: [
                                                                                                      TextIconButton(
                                                                                                        textButton: AppLocalizations.of(context).translate('Confirm'),
                                                                                                        bigText: true,
                                                                                                        textColor: AppColors.t3,
                                                                                                        icon: Icons.check_circle_outline,
                                                                                                        iconSize: 40.01.r,
                                                                                                        iconColor: AppColors.t2,
                                                                                                        iconLast: false,
                                                                                                        firstSpaceBetween: 3.w,
                                                                                                        buttonHeight: 53.h,
                                                                                                        borderWidth: 0.w,
                                                                                                        buttonColor: AppColors.white,
                                                                                                        borderColor: Colors.transparent,
                                                                                                        onPressed: (){
                                                                                                          //context.read<DeleteStudentCubit>().fetchDeleteStudent(id: state.showResult.students.data![index].id);
                                                                                                          Navigator.pop(dialogContext);
                                                                                                        },
                                                                                                      ),
                                                                                                      SizedBox(width: 42.w,),
                                                                                                      TextIconButton(
                                                                                                        textButton: AppLocalizations.of(context).translate('       Cancel       '),
                                                                                                        textColor: AppColors.t3,
                                                                                                        iconLast: false,
                                                                                                        buttonHeight: 53.h,
                                                                                                        borderWidth: 0.w,
                                                                                                        borderRadius: 4.r,
                                                                                                        buttonColor: AppColors.w1,
                                                                                                        borderColor: AppColors.w1,
                                                                                                        onPressed: (){
                                                                                                          Navigator.pop(dialogContext);
                                                                                                        },
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                            ),
                                                                          );
                                                                        },
                                                                        itemCount: count > 4 ? 4 : count,
                                                                        shrinkWrap: true,
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      );
                                    }
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 238.0.h,
                                      left: 77.0.w,
                                      bottom: 27.0.h),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Column(
                                          children: [
                                            CustomCourseInformation(
                                              image: stateDC.course.course.photo,
                                              bodyText: stateDC.course.course.description,
                                              onTap: () {},
                                              onTapDate: () {},
                                              onTapFirstIcon: (){},
                                              onTapSecondIcon: (){},
                                            ),
                                            SizedBox(height: 22.h),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                        ),
                      ),
                    );
                  } else if (state is SectionsFailure) {
                    return CustomErrorWidget(
                        errorMessage: state.errorMessage);
                  } else {
                    return CustomCircularProgressIndicator();
                  }
                }
            );
          } else if(stateDC is DetailsCourseFailure) {
            return CustomErrorWidget(
                errorMessage: stateDC.errorMessage);
          } else {
            return CustomCircularProgressIndicator();
          }
        }
    );
  }
}

String formatTimeOfDay(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

class CustomStartEndTimePicker extends StatelessWidget {
  const CustomStartEndTimePicker({super.key, required this.dayName, required this.startTimeController, required this.endTimeController});

  final String dayName;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CustomLabelTextFormField(
            labelText: dayName,
            showLabelText: true,
            hintText: AppLocalizations.of(context).translate('Start time'),
            readOnly: true,
            controller: startTimeController,
            topPadding: 0
                .h,
            leftPadding: 0
                .w,
            rightPadding: 0
                .w,
            bottomPadding: 38
                .h,
            onTap: () async {
              TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                startTimeController.text = formatTimeOfDay(time);
              }
            },
          ),
        ),
        SizedBox(
          width: 13.w,),
        Expanded(
          flex: 1,
          child: CustomLabelTextFormField(
            labelText: '',
            showLabelText: true,
            hintText: AppLocalizations.of(context).translate('End time'),
            readOnly: true,
            controller: endTimeController,
            topPadding: 0
                .h,
            leftPadding: 0
                .w,
            rightPadding: 0
                .w,
            bottomPadding: 38
                .h,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                final startParts = startTimeController.text.split(':');
                if (startParts.length == 2) {
                  final startHour = int.parse(startParts[0]);
                  final startMinute = int.parse(startParts[1]);

                  final startTime = TimeOfDay(hour: startHour, minute: startMinute);
                  final isEndAfterStart = pickedTime.hour > startTime.hour ||
                      (pickedTime.hour == startTime.hour &&
                          pickedTime.minute > startTime.minute);

                  if (!isEndAfterStart) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).translate('End time should be after start time!'))),);
                    return;
                  }

                  endTimeController.text =
                  '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context).translate('Please choose start time first!'))),
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}

double calculateWidthBetweenAvatars({
  required int avatarCount
})
{
  double width = 8.6;
  if(avatarCount >= 1) {
    width = 496.w;
  }
  if(avatarCount >= 2) {
    width = 442.w;
  }
  if(avatarCount >= 3) {
    width = 386.w;
  }
  if(avatarCount >= 4) {
    width = 328.w;
  }
  if(avatarCount >= 5) {
    width = 270.w;
  }
  return width;
}

String handleReciveState({required String state}) {
  if(state == 'pending') {
    return 'In preparation';
  } else if(state == 'in_progress') {
    return 'Active now';
  } else if(state == 'finished') {
    return 'Complete';
  } else {
    return '';
  }
}

String handleSendState({required String state}) {
  if(state == 'In preparation') {
    return 'pending';
  } else if(state == 'Active now') {
    return 'in_progress';
  } else if(state == 'Complete') {
    return 'finished';
  } else {
    return '';
  }
}