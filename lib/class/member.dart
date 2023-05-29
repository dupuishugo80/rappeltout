class Member {
  final int id;
  final String username;
  final String role;
  final int id_role;

  const Member({
    required this.id,
    required this.username,
    required this.role,
    required this.id_role
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        id: json['id'],
        role: json['role'],
        id_role: json['id_role'],
        username: json['username']
    );
  }
}
