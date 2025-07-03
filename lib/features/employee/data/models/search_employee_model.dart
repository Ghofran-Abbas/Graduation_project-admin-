// lib/features/employee/data/models/search_employee_model.dart

import 'package:intl/intl.dart';

class SearchEmployeeModel {
  final String message;
  final Employees employees;

  SearchEmployeeModel({
    required this.message,
    required this.employees,
  });

  factory SearchEmployeeModel.fromJson(Map<String, dynamic> json) => SearchEmployeeModel(
    message: json["message"],
    employees: Employees.fromJson(json["Employees"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Employees": employees.toJson(),
  };
}

class Employees {
  final int currentPage;
  final List<Datum>? data;
  final String firstPageUrl;
  final int? from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int? to;
  final int total;

  Employees({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final DateTime birthday;
  final String gender;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photo,
    required this.birthday,
    required this.gender,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    final rawBirthday = json['birthday'] as String;
    // support both "dd-MM-yyyy" and "yyyy/M/d"
    final birthday = rawBirthday.contains('-')
        ? DateFormat('dd-MM-yyyy').parse(rawBirthday)
        : DateFormat('yyyy/M/d').parse(rawBirthday);

    return Datum(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      photo: json["photo"],
      birthday: birthday,
      gender: json["gender"],
      role: json["role"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    'birthday': DateFormat('dd-MM-yyyy').format(birthday),

    "gender": gender,
    "role": role,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
