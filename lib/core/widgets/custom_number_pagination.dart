
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_paginator/number_paginator.dart';

class CustomNumberPagination extends StatelessWidget {
  const CustomNumberPagination({
    Key? key,
    required this.numberPages,
    required this.initialPage,
    required this.onPageChange,
  }) : super(key: key);

  final int numberPages;
  final int initialPage;
  final ValueChanged<int> onPageChange;

  @override
  Widget build(BuildContext context) {
    if (numberPages <= 1) {
      return SizedBox(width: 0.w, height: 0.h);
    }

    return NumberPaginator(
      numberPages: numberPages,
      initialPage: initialPage,
      onPageChange: onPageChange,
    );
  }
}
