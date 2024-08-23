class UserModel {
  String id;
  String name;
  String email;

  UserModel({required this.name, required this.email, required this.id});

  UserModel.fromjson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
        );
  Map<String, dynamic> tojson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
