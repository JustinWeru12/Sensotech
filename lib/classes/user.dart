class UserData {
  final int? id;
  final String? fullName;
  final String? email;
  final int? sensotechClientId;

  UserData({
    this.id,
    this.fullName,
    this.email,
    this.sensotechClientId,
  });

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        id: json["id"],
        fullName: json["FullName"],
        email: json["Email"],
        sensotechClientId: json["SensotechClientId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "FullName": fullName,
        "Email": email,
        "SensotechClientId": sensotechClientId,
      };
}
