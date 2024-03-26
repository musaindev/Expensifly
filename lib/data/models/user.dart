/// Represents a user entity with basic information such as username, phone number, password,
/// confirmation password, FCM token, user ID, and deposit amount.
class User {
  /// The username of the user.
  final String userName;

  /// The phone number of the user.
  final String phoneNo;

  /// The password of the user.
  final String password;

  /// The confirmation password of the user.

  /// The FCM token of the user for push notifications.
  final String fcmToken;

  /// The unique identifier of the user.
  final String userId;

  /// The deposit amount of the user.
  double deposit;

  /// Constructs a new User instance.
  ///
  /// [userName] represents the username of the user.
  /// [phoneNo] represents the phone number of the user.
  /// [password] represents the password of the user.
  /// [confirmPassword] represents the confirmation password of the user.
  /// [fcmToken] represents the FCM token of the user.
  /// [userId] represents the unique identifier of the user.
  /// [deposit] represents the deposit amount of the user, default is 0.0.
  User({
    required this.userName,
    required this.phoneNo,
    required this.password,
    required this.fcmToken,
    required this.userId,
    this.deposit = 0.0,
  });

  /// Converts the User object to a map representation.
  ///
  /// Returns a map containing the username, phone number, password,
  /// confirmation password, and FCM token.
  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "phoneNo": phoneNo,
      "password": password,
      'fcmToken': fcmToken,
    };
  }

  /// Constructs a new User instance from a map.
  ///
  /// [map] is the map containing the user data.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['userName'] ?? "",
      phoneNo: map['phoneNo'] ?? "",
      password: map['password'] ?? "",
      fcmToken: map['fcmToken'] ?? "",
      userId: map['userId'] ?? "",
    );
  }
}
