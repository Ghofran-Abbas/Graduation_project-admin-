class DepartmentsModel {
  final String message;
  final Departments departments;

  DepartmentsModel({
    required this.message,
    required this.departments,
  });

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) => DepartmentsModel(
    message: json["message"],
    departments: Departments.fromJson(json["departments"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "departments": departments.toJson(),
  };
}

class Departments {
  final int currentPage;
  final List<DepartmentDatum>? data;
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

  Departments({
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

  factory Departments.fromJson(Map<String, dynamic> json) => Departments(
    currentPage: json["current_page"],
    data: List<DepartmentDatum>.from(json["data"].map((x) => DepartmentDatum.fromJson(x))),
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

class DepartmentDatum {
  final int id;
  final String name;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;

  DepartmentDatum({
    required this.id,
    required this.name,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DepartmentDatum.fromJson(Map<String, dynamic> json) => DepartmentDatum(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
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