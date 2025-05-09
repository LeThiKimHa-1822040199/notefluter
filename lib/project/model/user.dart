class User {
  final String id, username, password, email;
  final String? avatar;
  final DateTime createdAt, lastActive;
  final bool isAdmin;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    this.avatar,
    required this.createdAt,
    required this.lastActive,
    this.isAdmin = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'username': username,
    'password': password,
    'email': email,
    'avatar': avatar,
    'createdAt': createdAt.toIso8601String(),
    'lastActive': lastActive.toIso8601String(),
    'isAdmin': isAdmin ? 1 : 0,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'],
    username: map['username'],
    password: map['password'],
    email: map['email'],
    avatar: map['avatar'],
    createdAt: DateTime.parse(map['createdAt']),
    lastActive: DateTime.parse(map['lastActive']),
    isAdmin: map['isAdmin'] == 1,
  );
}