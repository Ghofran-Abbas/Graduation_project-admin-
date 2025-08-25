import 'package:equatable/equatable.dart';

class YearlyStudentStat extends Equatable {
  final int year;
  final int totalStudents;
  const YearlyStudentStat({required this.year, required this.totalStudents});

  factory YearlyStudentStat.fromJson(Map<String, dynamic> json) {
    return YearlyStudentStat(
      year: json['year'] as int,
      totalStudents: (json['total_students'] as num).toInt(),
    );
  }

  @override
  List<Object?> get props => [year, totalStudents];
}

class YearlyStudentsPayload {
  final String message;
  final List<YearlyStudentStat> data;
  YearlyStudentsPayload({required this.message, required this.data});

  factory YearlyStudentsPayload.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List<dynamic>)
        .map((e) => YearlyStudentStat.fromJson(e as Map<String, dynamic>))
        .toList();
    return YearlyStudentsPayload(
      message: json['message'] as String? ?? '',
      data: list,
    );
  }
}

class MonthlyStudentStat extends Equatable {
  final int month; // 1..12
  final int totalStudents;
  final String? monthName; // optional
  const MonthlyStudentStat({required this.month, required this.totalStudents, this.monthName});

  factory MonthlyStudentStat.fromJson(Map<String, dynamic> json) {
    return MonthlyStudentStat(
      month: (json['month'] as num).toInt(),
      totalStudents: (json['total_students'] as num).toInt(),
      monthName: json['month_name'] as String?,
    );
  }

  @override
  List<Object?> get props => [month, totalStudents, monthName];
}

class MonthlyStudentsPayload {
  final String message;
  final List<MonthlyStudentStat> data;
  MonthlyStudentsPayload({required this.message, required this.data});

  factory MonthlyStudentsPayload.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List<dynamic>)
        .map((e) => MonthlyStudentStat.fromJson(e as Map<String, dynamic>))
        .toList();
    return MonthlyStudentsPayload(
      message: json['message'] as String? ?? '',
      data: list,
    );
  }
}
