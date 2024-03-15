import 'dart:convert';

List<Welcome> userModelFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String formLink;
  String message;
  bool status;

  Welcome({
    required this.formLink,
    required this.message,
    required this.status,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    formLink: json["formLink"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "formLink": formLink,
    "message": message,
    "status": status,
  };
}