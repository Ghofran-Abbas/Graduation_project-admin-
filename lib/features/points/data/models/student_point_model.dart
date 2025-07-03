

class StudentPoint {
  final int id;
  final String name;
  final String email;
  final int points;
  final String? photo;

  StudentPoint({
    required this.id,
    required this.name,
    required this.email,
    required this.points,
    this.photo,
  });

  factory StudentPoint.fromJson(Map<String, dynamic> json) {
    return StudentPoint(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      points: json['points'] as int,
      photo: json['photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'points': points,
    'photo': photo,
  };
}
