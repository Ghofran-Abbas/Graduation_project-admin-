class SecretaryPoint {
  final int id;
  final String name;
  final String email;
  final int points;
  final String? photo;
  final String? phone;
  final String? birthday;
  final String? gender;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SecretaryPoint({
    required this.id,
    required this.name,
    required this.email,
    required this.points,
    this.photo,
    this.phone,
    this.birthday,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  factory SecretaryPoint.fromJson(Map<String, dynamic> json) {
    return SecretaryPoint(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      points: json['points'] as int,
      photo: json['photo'] as String?,
      phone: json['phone'] as String?,
      birthday: json['birthday'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'points': points,
    if (photo != null) 'photo': photo,
    if (phone != null) 'phone': phone,
    if (birthday != null) 'birthday': birthday,
    if (gender != null) 'gender': gender,
  };
}
