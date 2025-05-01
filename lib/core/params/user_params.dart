class UserParams {
  final String displayName;
  final String? description;

  UserParams({required this.displayName, this.description});

  UserParams.fromJson(Map<String, dynamic> json)
      : displayName = json['displayName'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'description': description,
      };
}
